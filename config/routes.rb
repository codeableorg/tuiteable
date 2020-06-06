Rails.application.routes.draw do
  get 'user/show'
  get 'user/create'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root "home#index"
  resources :tuits, only: [:index, :show, :new, :create, :destroy]
  resources :tuits do
    resources :likes, module: :tuits, only: [:create, :destroy]
    resources :comments, module: :tuits, only: [:create]
  end
  namespace :api, defaults: { format: :json } do
    resources :tuits, only: [:index, :show, :create, :destroy] do
      resources :comments, module: :tuits, only: [:index, :show, :create, :destroy]
      resources :likes, module: :tuits, only: [:index, :create, :destroy]
    end
    resources :users, only: :none do
      resources :tuits, module: :users, only: [:index, :show]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

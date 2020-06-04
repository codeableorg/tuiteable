Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root "home#index"
  resources :tuits, only: [:index, :show, :new, :create, :destroy]
  resources :tuits do
    resources :likes, module: :tuits, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

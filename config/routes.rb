Rails.application.routes.draw do
  resources :tweets do
    resources :comments
    post 'like', on: :member
  end
  resources :comments do
    resources :comments 
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "home#index"
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    resources :tweets, only: [:index, :show, :create, :update, :destroy] do
      resources :comments, only: [:index, :show, :create, :update, :destroy], module: 'tweets'
    end
    post "sign_in", to: "sessions#create"
    delete "log_out", to: "sessions#destroy"

    resources :users, only: [:create] do
      resources :tweets, only: [:index, :show], module: 'users'
    end
  end
end

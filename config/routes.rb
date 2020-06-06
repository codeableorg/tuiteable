Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :tweets, only: [:create, :destroy, :show] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :users do
    resources :tweets, only: [:index]
    resources :favorites, only: [:index]
  end
  namespace :api, defaults: {format: :json}  do
      devise_scope :user do
        post "users", to: "registrations#create"
        post "sessions/sign_in", to: "sessions#create"
        delete "sessions/log_out", to: "destroy_sessions#destroy"
      end
      resources :tuits, only: [:index, :show, :create, :update, :destroy] do
        resources :comments, only: [:index, :show, :create, :destroy, :update]
        resources :likes, only: [:show,:create,:destroy, :index]
      end
      resources :users do
        resources :tuits, only: [:show,:index]
      end
  end
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

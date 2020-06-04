Rails.application.routes.draw do
  resources :tweets, only: [:destroy]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    resources :tweets, only: [:index]
    post "sign_in", to: "sessions#create"
    delete "log_out", to: "sessions#destroy"

    resources :users, only: [:create] do
      resources :tweets, only: [:index, :show], module: 'users'
    end

    resources :tweets, only: [:create, :update, :destroy]
  end
end

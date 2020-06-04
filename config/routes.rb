Rails.application.routes.draw do
  resources :tweets, only: [:destroy]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :tweets, only: [:index]
  end
end

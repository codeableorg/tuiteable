Rails.application.routes.draw do
  get 'comments/create'
  get 'profile' ,to: 'users#index'
  resources :users , only:[:update, :edit]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'tweets#index'

  resources :tweets, only: [:index, :show] do
    resources :comments, only: [:create]
  end

  namespace :api do

    post 'sessions/sign_in', to: 'sessions#create'
    
    resources :tweets, only: [:index, :show, :create, :destroy]

    resources :users , only: [:index] do
      resources :tweets, only: [:index, :show]
    end

    resources :tweets , only: [:index, :show] do
      resources :comments, only: [:index, :show, :create,:destroy]
    end

    resources :tweets , only: [:index] do
      resources :likes, only: [:index, :create,:destroy]
    end
  
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :users do
    resources :tweets, only: [:index]
    resources :favorites, only: [:index]
  end
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'porfile' ,to: 'users#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'tweets#index'

  resources :tweets, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

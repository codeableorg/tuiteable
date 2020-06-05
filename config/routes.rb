Rails.application.routes.draw do
  get 'explorer', to: 'tweets#index'
  get 'porfile' ,to: 'users#index'  
  get 'comments/create'
  get 'tcreate', to: 'tweets#new'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'tweets#index'  
  resources :tweets, only: [:index, :show, :create, :new] do
    resources :comments, only: [:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

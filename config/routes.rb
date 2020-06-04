Rails.application.routes.draw do
  root "tuits#index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tuits do
    resources :comments
  end
end

Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :tuits, only: [:show]
  resources :tuits do
    resources :likes, module: :tuits, only: [:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

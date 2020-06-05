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
end

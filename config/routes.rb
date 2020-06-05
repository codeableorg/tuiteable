Rails.application.routes.draw do
  root to: 'pages#root'
  resources :tweets do
    resources :likes
  end
  devise_for :users
  resources :users
end

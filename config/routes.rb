Rails.application.routes.draw do
  root to: 'pages#root'
  resources :tweets do
    resources :likes
  end
  devise_for :users
  resources :users
  get '/:tag', to: 'users#show'
  get '/:tag/:id', to: 'tweets#show'
  ## API
  namespace :api do
    resources :tweets
  end
  namespace :api do
    resources :users
  end
  namespace :api do
  resources :likes
  end

end

Rails.application.routes.draw do
  resources :tweets
  devise_for :users
  root to: 'pages#root'
  get '/:tag', to: 'users#show'
  get '/:tag/:id', to: 'tweets#show'
end

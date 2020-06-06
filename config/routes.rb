Rails.application.routes.draw do
<<<<<<< HEAD
  get 'profile/tweets'
  get 'profile/liked_tweets'
=======
  resources :tweets, only: [:destroy, :create, :show]
  root to: "tweets#index"
  get 'profile/show'
>>>>>>> 60ae457c7f16040aa03d68616d7d89298a0b6ddf
  resources :tweets do
    resources :comments
    post 'like', on: :member, defaults: { format: 'js' }
  end
  resources :comments do
    resources :comments 
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    resources :tweets, only: [:index, :show, :create, :update, :destroy] do
      resources :comments, only: [:index, :show, :create, :update, :destroy], module: 'tweets'
      resources :likes, only: [:index, :create, :destroy], module: 'tweets'
    end
    post "sign_in", to: "sessions#create"
    delete "log_out", to: "sessions#destroy"

    resources :users, only: [:create] do
      resources :tweets, only: [:index, :show], module: 'users'
    end
  end
end

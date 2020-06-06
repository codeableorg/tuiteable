# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show
  get 'home/index'
  resources :tuits do
    resources :comments, only: :create
    resources :likes, only: :create
  end
  root to: 'tuits#index'
  get '/my_profile', to: 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # API
  namespace :api, defaults: { format: :json } do
    resources :tuits, only: %i[create index show update destroy]

    get 'users/:user_id/tuits', to: 'users#user_tuits'
    get 'users/:user_id/tuits/:id', to: 'users#show_user_tuit'

    get 'tuits/:tuit_id/comments', to: 'tuit_comments#tuit_comments'
    get 'tuits/:tuit_id/comments/:comment_id', to: 'tuit_comments#show_tuit_comment'
    post 'tuits/:tuit_id/comments', to: 'tuit_comments#create'
    delete 'tuits/:tuit_id/comments/:comment_id', to: 'tuit_comments#destroy'

    get 'tuits/:tuit_id/likes', to: 'tuit_likes#tuit_likes'
    post 'tuits/:tuit_id/likes', to: 'tuit_likes#create'
    delete 'tuits/:tuit_id/likes', to: 'tuit_likes#destroy'

    devise_scope :user do
      post 'users', to: 'registration#create'
      post 'session/sign_in', to: 'session#create', as: :new_user_session
      delete 'session/logout', to: 'session#logout', as: :destroy_session
    end
  end
end

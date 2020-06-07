# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/profile/:id', to: 'profiles#show', as: 'profile'
  get 'tuits/index'
  namespace :api do
    resources :comments, only: %i[index create destroy]
  end
  resources :tuits
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  put 'profiles/edit', to: 'profiles#edit'
  get '/profiles/profile/:id/liked', to: 'profiles#liked'
  get '/follow/:id', to: 'profiles#follow'
  get '/unfollow/:id', to: 'profiles#unfollow'
  get '/like/:id', to: 'tuits#like'
  post '/comment/:id', to: 'tuits#comment' # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show
  get 'home/index'
  resources :tuits
  root to: 'tuits#index'
  get '/my_profile', to: 'users#show'
end

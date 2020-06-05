# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show
  get 'home/index'
  resources :tuits
  root to: 'tuits#index'
  get '/my_profile', to: 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # API
  namespace :api, defaults: {format: :json} do
    resources :tuits, only: [:create]

    devise_scope :user do
      post "users", to: "registration#create"
    end

    namespace :session do 
      devise_scope :user do
        post "sign_in", to: "session#create"
        delete "logout", to: "session#logout"
      end
    end
  end
end

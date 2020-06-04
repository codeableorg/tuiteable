# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  resources :tuits
  # root to: 'home#index'
  root to: 'tuits#index'
end

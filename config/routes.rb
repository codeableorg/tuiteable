Rails.application.routes.draw do
  root "tuits#index"
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
  }

  get '/profile', to: 'users#show'
  resources :tuits do
    resources :comments
    member do
      get 'like', to: 'tuits#like'
    end
  end

  devise_scope :user do
    namespace :api, defaults: { format: 'json' } do
      post '/users', to: 'users#create'
      scope 'sessions' do
        post '/sign_in', to: 'sessions#create'
        post '/log_out', to: 'sessions#destroy'
      end

      resources :users, only: [] do
        resources :tuits, only: [:index, :show]
      end

      resources :tuits do
        resources :comments
        get 'likes', to: 'likes#index'
        post 'likes', to: 'likes#create'
        delete 'likes', to: 'likes#destroy'
      end
    end
  end
end

require 'sidekiq/web'
  
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api do
    namespace :v1 do
      resources :users, only: [ :create, :update ]
      resources :omniauths, only: [ :create ]
      resources :sessions, only: [ :create, :destroy ]

      match 'reset', to: 'users#reset', via: :post
      match 'verify/:token', to: 'users#verify', via: :post
      
    end
  end
  
end

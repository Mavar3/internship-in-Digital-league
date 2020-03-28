# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resource :login, only: %i[show create destroy]

  mount GrapeApi => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'

  get 'welcome/main'
  namespace :admin do
    root 'welcome#index'
    get 'welcome/index'
  end
  resources :users
  resources :orders
  resources :orders do
    member do
      get 'approve'
      get 'clacs'
      get 'first'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

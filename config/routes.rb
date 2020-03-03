Rails.application.routes.draw do
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

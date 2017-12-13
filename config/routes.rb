Rails.application.routes.draw do

  get 'random/outfit'

  
  root   'sessions#new'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/hamper',  to: 'hamper#index'
  post   'hamper/wash_all', to: 'hamper#wash_all'
  get 'random/clothes', to: 'random#outfit'
  resources :users
  resources :tops
  resources :bottoms
  resources :footwears
  resources :outfits
  resources :accessories
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end

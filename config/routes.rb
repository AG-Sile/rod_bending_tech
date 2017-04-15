Rails.application.routes.draw do
  root 'static_pages#home'

  get    '/home',        to: 'static_pages#home'
  get    '/about',       to: 'static_pages#about'
  get    '/help',        to: 'static_pages#help'
  get    '/products',    to: 'products#index'
  get    '/signup',      to: 'users#new'
  post   '/signup',      to: 'users#create'
  get    '/login',       to: 'sessions#new'
  post   '/login',       to: 'sessions#create'
  delete '/logout',      to: 'sessions#destroy'
  get   '/add_product',  to: 'products#new'
  post   '/add_product', to: 'products#create'
  resources :users
  resources :products
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
# Let’s encrypt
get '/.well-known/acme-challenge/:id' => 'static_pages#letsencrypt'
end

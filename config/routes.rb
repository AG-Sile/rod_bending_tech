Rails.application.routes.draw do
  root 'static_pages#home'

  get    '/home',         to: 'static_pages#home'
  get    '/about',        to: 'static_pages#about'
  get    '/help',         to: 'static_pages#help'
  get    '/products',     to: 'products#index'
  get    '/signup',       to: 'users#new'
  post   '/signup',       to: 'users#create'
  get    '/login',        to: 'sessions#new'
  post   '/login',        to: 'sessions#create'
  delete '/logout',       to: 'sessions#destroy'
  get    '/add_product',  to: 'products#new'
  post   '/add_product',  to: 'products#create'
  get    '/check_out_1',  to: 'shipping_addresses#new'
  post   '/check_out_1',  to: 'shipping_addresses#create'
  get    '/check_out_2',  to: 'orders#show_items'
  patch  '/check_out_2',  to: 'orders#update_items'
  get    '/check_out_3',  to: 'orders#new'
  get    '/user_index',   to: 'orders#user_index'
  post   '/create_shipping_label', to: 'order_items#create_shipping_transaction'
  get    '/add_product_variant',   to: 'product_variants#new'
  post   '/add_product_variant',   to: 'product_variants#create'

  resources :users
  resources :products
  resources :orders,               only: [:update, :index]
  resources :product_variants
  resources :shipping_addresses
  resources :account_activations, only: [:edit]
  resources :cart_items
  resources :password_resets,     only: [:new, :create, :edit, :update]
end

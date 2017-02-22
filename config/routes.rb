Rails.application.routes.draw do
  root 'static_pages#home'

  get '/home',     to: 'static_pages#home'
  get '/about',    to: 'static_pages#about'
  get '/help',     to: 'static_pages#help'
  get '/products', to: 'static_pages#products'
  post '/signup',  to: 'users#create'
  resources :users
  
end

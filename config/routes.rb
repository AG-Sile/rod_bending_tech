Rails.application.routes.draw do
  get '/home',    to: 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/help',    to: 'static_pages#help'
  get '/products', to: 'static_pages#products'
  root 'static_pages#home'
end

Rails.application.routes.draw do

  get 'sessions/new'

  root 'static_pages#home'
  get  '/terms', to: 'static_pages#terms'
  get  '/accounts/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
  get    '/accounts/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end

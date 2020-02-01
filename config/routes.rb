Rails.application.routes.draw do

  root 'static_pages#home'
  get  '/terms', to: 'static_pages#terms'
  get  '/accounts/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end

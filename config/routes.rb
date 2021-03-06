Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'static_pages#home'
  get  '/terms', to: 'static_pages#terms'
  get  '/accounts/signup',  to: 'users#new'
  post '/accounts/signup',  to: 'users#create'
  resources :users do
    member do
      get :fav_lists
    end
  end
  get    '/accounts/login',   to: 'sessions#new'
  post   '/accounts/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get  '/accounts/password/change',  to: 'users#password_change'
  post  '/accounts/password/change',  to: 'users#password_update'
  patch '/accounts/password/change', to: 'users#password_update'

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  resources :posts do
    resources :comments, only: [:index, :create, :destroy]
  end
  get    '/create',   to: 'posts#new'
  resources :relationships,       only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

  get '/explore', to: 'posts#explore'

  resources :notifications, only: [:index]
end

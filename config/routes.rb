Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'static_pages#home'
  get  '/terms', to: 'static_pages#terms'
  get  '/accounts/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users do
    member do
      get :following, :followers
    end
  end
  get    '/accounts/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get  '/accounts/password/change',  to: 'users#password_change'
  post  '/accounts/password/change',  to: 'users#password_update'
  patch '/accounts/password/change', to: 'users#password_update'

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  resources :posts, only: [:new, :show, :create, :destroy]
  get    '/create',   to: 'posts#new'
  resources :relationships,       only: [:create, :destroy]
end

Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home'
  get  '/terms', to: 'static_pages#terms'
end

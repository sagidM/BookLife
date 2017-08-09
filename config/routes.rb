p 'routes is initializing'

Rails.application.routes.draw do
  root 'home#index'

  resources :books

  # SessionsController
  match '/login', to: 'sessions#new', via: :get, as: :signin
  match '/login', to: 'sessions#create', via: :post
  match '/signout', to: 'sessions#destroy', via: :delete
  get '/users/find'


  # UsersController
  match '/register', to: 'users#new', via: :get, as: :signup
  match '/register', to: 'users#create', via: :post
  match '/users', to: 'users#index', via: :get
  match '/settings', to: 'users#edit_current_user', via: :get, as: :current_user_settings # only singed in
  match '/settings', to: 'users#update_current_user', via: :patch # only singed in
  resources :users, only: [:edit, :show] # only admin

end

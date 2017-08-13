p 'routes is initializing'

Rails.application.routes.draw do
  get 'author/index'

  get 'author/new'

  get 'author/create'

  get 'author/show'

  root 'home#index'

  # SessionsController
  match '/login(?redirect_to=:redirect_page)', to: 'sessions#new', via: :get, as: :signin
  match '/login', to: 'sessions#create', via: :post
  match '/signout(?redirect_to=:redirect_page)', to: 'sessions#destroy', via: :delete, as: :signout
  get '/users/find'


  # UsersController
  match '/register(?redirect_to=:redirect_page)', to: 'users#new', via: :get, as: :signup
  match '/register', to: 'users#create', via: :post
  match '/users', to: 'users#index', via: :get
  match '/settings', to: 'users#edit_current_user', via: :get, as: :current_user_settings # only singed in
  match '/settings', to: 'users#update_current_user', via: :patch # only singed in
  resources :users, only: [:edit, :show] # only admin


  resources :books
  match 'books/new' => 'books#create', via: :post


  resources :authors
  match 'authors/new' => 'authors#create', via: :post


  resources :publishing_houses
  match 'publishing_houses/new' => 'publishing_houses#create', via: :post
end

Rails.application.routes.draw do
  root 'home#index'
  match '/register', to: 'users#new', via: :get, as: :signup
  match '/register', to: 'users#create', via: :post
  match '/login', to: 'sessions#new', via: :get, as: :signin
  match '/login', to: 'sessions#create', via: :post
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/users', to: 'users#index', via: :get
end

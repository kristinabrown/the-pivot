Rails.application.routes.draw do
  resources :beers, only: [:show, :index]
  resource :users
  resource :cart_items, only: [:create, :update, :index]

  resources :orders
  
  namespace :admin do
    resources :beers
    resources :categories
    resources :orders, except: [:new, :create]
  end  

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'staticpages#index'
end

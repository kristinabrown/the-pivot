Rails.application.routes.draw do
  resources :beers, only: [:show, :index]
  resource :users
  resources :cart_items

  namespace :user do 
    resources :orders
  end

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

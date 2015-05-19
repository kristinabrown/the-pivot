Rails.application.routes.draw do
  # resources :beers, only: [:show, :index]
  # resource :users
  # resources :cart_items, only: [:edit, :create, :update, :index, :destroy]
  # resources :orders
  # 
  # resources :charges
  # 
  # namespace :admin do
  #   get '/dashboard', to: 'dashboard#index'
  #   resources :beers
  #   resources :categories
  #   resources :orders, except: [:new, :create]
  # end
  # 
  # get '/login', to: 'sessions#new'
  # post '/login', to: 'sessions#create'
  # delete '/logout', to: 'sessions#destroy'
  # post 'cart_items/increase', to: 'cart_items#increase'
  # post 'cart_items/decrease', to: 'cart_items#decrease'

  root 'staticpages#index'
  
  resources :stores, only: [:index]
  
  namespace :stores, as: :store, path: '/:store' do 
    resources :items,  only: [:index, :show]
  end
end

Rails.application.routes.draw do
  resource :users
  resources :watch_items, only: [:edit, :create, :update, :index, :destroy]
  resources :orders
  resources :bids
  resources :pending_bids, only: [:create]

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
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/all_items', to: 'items#index'
  
  root 'staticpages#index'
  
  resources :stores, only: [:index]
  
  namespace :stores, as: :store, path: '/:store' do 
    resources :items,  only: [:index, :show]
  end
end

Rails.application.routes.draw do
  resource :users
  resources :watch_items, only: [:edit, :create, :update, :index, :destroy]
  resources :orders
  resources :bids
  resources :pending_bids, only: [:create]

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/all_items', to: 'items#index'
  
  root 'staticpages#index'
  
  resources :stores
  
  namespace :stores, as: :store, path: '/:store' do 
    resources :items,  only: [:index, :show, :new, :edit, :update]
  end
end

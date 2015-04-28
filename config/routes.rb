Rails.application.routes.draw do
  resources :beers, only: [:show, :index]
  resource :users

  namespace :user do 
    resources :orders
  end

  namespace :admin do
    resources :beers
    resources :categories
    resources :orders
  end  

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'staticpages#index'
end

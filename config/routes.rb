Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  root to: 'posts#index'

  resources :posts
  
  resources :users, only: [:show, :create, :edit, :update, :destroy]
  resources :posts, only: [:index, :show]
end
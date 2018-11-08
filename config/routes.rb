Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  
  root to: 'relationships#index'
  resources :users, only: [:show, :create, :destroy] do
    member do
      get :posts
    end
    collection do
      get :search
    end
  end
  resources :relationships, only: [:create, :destroy]
  
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
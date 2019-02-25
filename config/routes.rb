Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  
  # root to: 'relationships#index'
  resources :users, only: [:show, :new, :create, :destroy] do
    resource :profiles, only: [:show, :new, :create, :edit, :update]
    member do
      get :relationship_posts
      get :post_users
      get :finished_posts
      get :finished_users
      get :post_evaluate
      post :post_evaluate, to:"users#make_evaluate"
    end
    collection do
      get :search
    end
  end
  resources :relationships, only: [:create, :destroy, :update]
  resources :points, only: [:create]
  resources :hexagons, only: [:show, :create, :edit, :update]
  
  resources :users
  resources :posts do
    #collection do
      #get :search_posts
    #end
    member do
      get :relation_users
    end
  end
end
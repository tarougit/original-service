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
    end
    collection do
      get :search
    end
  end
  resources :relationships, only: [:create, :destroy,]
  
  #resources :profiles, only: [:show, :new, :create, :edit, :update]
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
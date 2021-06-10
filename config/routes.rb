Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  get 'password_changes/edit'
  get 'password_changes/update'
  root 'top_pages#top'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/signup',   to: 'users#new'
  resources :groups do
    member do
      get :members
      get :join
      delete :exit
      resources :posts, only: [:create, :destroy]
    end
  end
  resources :users
  resources :password_changes, only: [:new, :create, :edit, :update]
end

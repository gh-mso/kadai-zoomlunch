Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :joinedrooms
      get :rooms
    end
  end
  
  get 'rooms', to: 'toppages#index'
  get 'rooms/new/:id', to: 'rooms#new', as: :rooms_new
  resources :rooms, only: [:show, :edit, :update, :create, :destroy]
  
  resources :room_members, only: [:create, :destroy]
end

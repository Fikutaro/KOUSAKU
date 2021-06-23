Rails.application.routes.draw do
  get 'uploads/create'
  get 'uploads/destroy'
  devise_for :users
  resources :users, only: [:show, :edit, :update, :create] do
    get :favorites, on: :collection
  end

  resources :articles, only: [:index, :show, :edit, :update, :create, :new ,:destroy] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get 'search' => 'articles#search'

  resources :uploads, only: [:create, :destroy]

  root :to => "homes#top"
  get "homes/about" =>"homes#about"
  get "favorites" =>"favorites#index"

end

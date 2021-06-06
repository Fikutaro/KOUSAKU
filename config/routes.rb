Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update, :create] do
    get :favorites, on: :collection
  end

  resources :articles, only: [:index, :show, :edit, :update, :create, :new ,:destroy] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end


  get "favorites" =>"favorites#index"

  root :to => "homes#top"
  get "homes/about" =>"homes#about"


end

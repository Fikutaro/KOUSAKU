Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update, :create]
  resources :articles, only: [:index, :show, :edit, :update, :create, :new]

  root :to => "homes#top"
  get "homes/about" =>"homes#about"
  
  
end

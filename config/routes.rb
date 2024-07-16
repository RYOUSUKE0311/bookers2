Rails.application.routes.draw do
  devise_for :users
   root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  resources :books, only: [:show, :edit, :update, :index, :create, :destroy]
  resources :users, only: [:show, :edit, :update, :index]

end

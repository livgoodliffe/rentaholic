Rails.application.routes.draw do
  devise_for :users

  resources :users, only: :show

  resources :items, only: [:index, :show]

  resources :bookings do
    resources :reviews, only: :create
  end

  root to: 'pages#home'

  get 'categories', to:'items#index', as: :categories

  resources :items, only: [:index, :show, :new, :create] do
    resources :bookings
  end

  resources :wishlists
end

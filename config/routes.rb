Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show]

  resource :dashboard, only: :show

  resources :items, only: [:index, :new, :create, :show]

  resources :bookings do
    resources :reviews, only: :create
  end

  root to: 'pages#home'

  get 'categories', to:'items#index', as: :categories

  resources :items, only: [:index, :show] do
    resources :bookings
    resources :wishlists, only: :create
  end

  resources :wishlists
  resources :wishlists, only: :destroy
end

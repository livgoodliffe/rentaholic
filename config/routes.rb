Rails.application.routes.draw do
  devise_for :users

  resources :items, only: [:index, :show] do
    resources :users, only: [:first_name, :last_name, :city]
  end
  resources :bookings do
    resources :reviews, only: :create
  end

  root to: 'items#index'

  resources :items, only: [:index, :show] do
    resources :bookings
  end

end

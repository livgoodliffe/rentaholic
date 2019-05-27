Rails.application.routes.draw do
  devise_for :users

  resources :items, only: [:index, :show]
  resources :bookings

  root to: 'items#index'
end

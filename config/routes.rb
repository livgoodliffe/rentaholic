Rails.application.routes.draw do
  devise_for :users

  resources :items, only: [:index, :show] do
    resources :users, only: [:first_name, :last_name, :city]
  end
  resources :bookings

  root to: 'items#index'
end

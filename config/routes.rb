Rails.application.routes.draw do
  devise_for :users

  resources :items
  resources :bookings, except: :index

  root to: 'items#index'
end

Rails.application.routes.draw do
  devise_for :users

  resources :items
  resources :bookings, except: :index

  root to: 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

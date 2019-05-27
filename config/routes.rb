Rails.application.routes.draw do
  get 'items/index'
  get 'items/show'
  devise_for :users

  root to: 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

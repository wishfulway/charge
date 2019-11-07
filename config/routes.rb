Rails.application.routes.draw do


  resources :wallets
  resources :account_type_services
  resources :services
  resources :accounts
  root to: 'home#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

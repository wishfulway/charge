Rails.application.routes.draw do

  root to: 'home#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #


  resources :accounts do
    get 'inquiry', on: :member
    put 'change', on: :member
  end

  resources :wallets do

  end
  resources :account_type_services
  resources :services





end

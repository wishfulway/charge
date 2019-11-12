Rails.application.routes.draw do

  root to: 'home#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  # resources :banks,  :as => :accounts, :controller => :accounts
  # map.resources :qr,      :as => :accounts, :controller => :vehicles
  # map.resources :motorcycles, :as => :accounts, :controller => :vehicles


  resources :accounts do
    resources :wallets do
      # get 'bid_account/:account_id', on: :collection, to: "wallets#show_wallets_bid_account"
    end
    # get 'with_wallets', on: :member, to: "accounts#show_wallets"
    # get 'new_wallet', on: :member, to: "accounts#create_wallet"
  end


  resources :wallets, only: [:destroy, :create, :update]

  resources :account_type_services
  resources :services do

  end

  namespace :admin do

    resources :users, only: [:index] do

    end

    resources :services

    resources :account_type_services

  end



end

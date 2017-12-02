Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      match "*path", via: [:options], to: "cors#preflight", as: :preflight_cors

      resources :bills, only: [:show]
      resources :carts, except: [:show] do
        get  :items, to: "carts#items", as: :items
        post "add_item/:product_code", to: "carts#add_item", as: :add_item
        post "delete_item/:product_code", to: "carts#delete_item", as: :delete_item
        post "update_item/:product_code", to: "carts#update_item", as: :update_item
      end
      resources :users do
        get :active_transaction, to: "users#active_transaction", as: :active_transaction
      end
      get  "carts/:transaction_code", to: "carts#show", as: :carts_show
      get "transactions/:transaction_code/bill", to: "transactions#get_bill", as: :get_bill
      post "transactions/:transaction_code/checkout", to: "transactions#checkout", as: :checkout
      resources :transactions
      resources :stores, only: [:index, :show] do
        get :products, to: "stores#products", as: :products
        get :transactions, to: "stores#transactions", as: :transactions
      end
      get "products/:product_code", to: "products#show", as: :product_show
    end
  end
end

Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      match "*path", via: [:options], to: "cors#preflight", as: :preflight_cors

      resources :carts do
        get  :items, to: "carts#items", as: :items
        post "add_item/:product_code", to: "carts#add_item", as: :add_item
        post "delete_item/:product_code", to: "carts#delete_item", as: :delete_item
        post "update_item/:product_code", to: "carts#update_item", as: :update_item
      end
      resources :users do
        get :active_transaction, to: "users#active_transaction", as: :active_transaction
      end
      resources :transactions do
        post :checkout, to: "transactions#checkout", as: :checkout
      end
      resources :stores, only: [:index, :show] do
        get :products, to: "stores#products", as: :products
      end
      resources :products, only: [:show]
    end
  end
end

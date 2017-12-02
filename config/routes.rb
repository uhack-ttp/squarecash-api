Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      match "*path", via: [:options], to: "cors#preflight", as: :preflight_cors

      resources :users do
        get :active_transaction, to: "users#active_transaction", as: :active_transaction
      end
      resources :transactions do
        get :cart, to: "transactions#current_cart", as: :cart
      end
      resources :stores, only: [:index, :show] do
        get :products, to: "stores#products", as: :products
      end
      resources :products, only: [:show]
    end
  end
end

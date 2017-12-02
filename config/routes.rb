Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      match "*path", via: [:options], to: "cors#preflight", as: :preflight_cors

      resources :users
      resources :transactions
    end
  end
end

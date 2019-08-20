Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers, except: [:update, :destroy] do
        get "orders", to: "orders#index"
        post "orders", to: "orders#create"
      end
      resources :products, only: [:index, :show]
      resources :orders, only: [:show] do
        get "products", to: "products#index"
        post "products", to: "products#create"
      end
      put "orders/:id/ship", to: "orders#ship"
    end
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      
      get "/items/find_all", to: 'search#find_items', controller: :search
      get "/merchants/find", to: 'search#find_merchant'


      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end

      resources :items, only: [:index, :show, :create, :destroy, :update]

      get "/items/:id/merchant", to: 'merchant_items#show'
    end
  end
end

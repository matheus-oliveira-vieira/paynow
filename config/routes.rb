Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: "registrations" }
  resources :companies do
    patch 'refresh_token', to: 'companies#refresh_token'
    resources :payment_methods do
      resources :discounts
    end
    resources :products 
  end
  resources :payments do
    patch 'activate', to: 'payments#activate'
    patch 'inactivate', to: 'payments#inactivate'
  end

  resources :charges

  namespace :api do
    namespace :v1 do
      resources :clients do
        patch 'generate_token', to: 'clients#generate_token'
      end
      resources :charges
      get 'search_by_expiration_date', to:"charges#search_by_expiration_date"
      get 'search_by_payment_method', to:"charges#search_by_payment_method"
    end
  end

end

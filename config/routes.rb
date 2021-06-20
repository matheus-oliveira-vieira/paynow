Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: "registrations" }
  resources :companies do
    patch 'refresh_token', to: 'companies#refresh_token'
    resources :payment_methods
  end
  resources :payments do
    patch 'activate', to: 'payments#activate'
    patch 'inactivate', to: 'payments#inactivate'
  end
end

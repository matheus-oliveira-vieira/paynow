Rails.application.routes.draw do
  root 'home#index'
  resources :companies
  resources :payments do
    patch 'activate', to: 'payments#activate'
    patch 'inactivate', to: 'payments#inactivate'
  end
end

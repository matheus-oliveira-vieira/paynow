Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :companies
  resources :payments do
    patch 'activate', to: 'payments#activate'
    patch 'inactivate', to: 'payments#inactivate'
  end
end

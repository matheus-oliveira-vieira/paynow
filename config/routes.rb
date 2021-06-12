Rails.application.routes.draw do
  root 'home#index'
  resources :companies
  resources :payments
end

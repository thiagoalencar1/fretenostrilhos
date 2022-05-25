Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root 'home#index'

  resources :carriers, only: %i[index show new create edit update]
  resources :vehicles, only: %i[index new create edit update]
  resources :price_ranges, only: [:index]
  resources :distance_prices, only: %i[index new create edit update]
  resources :orders, only: %i[index new create]
end

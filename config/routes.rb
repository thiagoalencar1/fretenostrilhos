Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins
  devise_for :users

  resources :carriers, only: %i[index show new create edit update]
  resources :vehicles, only: %i[index new create edit update]
  resources :price_ranges, only: %i[index show new create edit update]
  resources :distance_prices, only: %i[index new create edit update]
  resources :orders, only: %i[index new create edit update]
  resources :delivery_distances, only: %i[index new create edit update]
  resources :delivery_times, only: %i[index new create edit update]

  resources :budgets, only: %i[index]
end

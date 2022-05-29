Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :carriers, only: %i[index show new create edit update]
    resources :price_ranges, only: %i[index show new create edit update]
    resources :delivery_distances, only: %i[index new create edit update]
  end

  namespace :user do
    resources :vehicles, only: %i[index new create edit update]
    resources :distance_prices, only: %i[index new create edit update]
    resources :delivery_times, only: %i[index new create edit update]
  end

  resources :orders, only: %i[index show new create edit update] do
    get 'search', on: :collection
    get 'budgets', on: :collection
    post 'accepted', on: :member
    post 'delivered', on: :member
    post 'rejected', on: :member
  end
end

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :carriers, only: [:index]
end

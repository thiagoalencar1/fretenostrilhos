Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :carriers, only: %i[index show new create edit update]
  resources :vehicles, only: %i[index new create edit update]
end

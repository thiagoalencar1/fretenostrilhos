Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :carriers, only: %i[index show new create edit update]
end

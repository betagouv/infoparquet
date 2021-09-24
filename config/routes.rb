Rails.application.routes.draw do
  resources :entities
  resources :signalements
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "/users" => 'users#index'
  root "index#index"
end

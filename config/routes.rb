Rails.application.routes.draw do
  resources :signalements
  devise_for :users, path: 'account', controllers: { registrations: 'users/registrations' }
  get '/account', to: 'account#show'
  resources :users, only: [:index, :show]
  
  post '/webhook', to: 'webhook#event'

  root "index#index"
end

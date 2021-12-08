Rails.application.routes.draw do
  resources :administration_services
  resources :administrations
  resources :signalements
  devise_for :users, path: 'account', controllers: { registrations: 'users/registrations' }
  get '/account', to: 'account#show'
  
  resources :users, only: [:index, :show]

  post '/ds/event', to: 'ds#event'
  get '/ds/dossiers', to: 'ds#index'

  root "index#index"
end

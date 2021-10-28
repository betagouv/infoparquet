Rails.application.routes.draw do
  resources :signalements
  devise_for :users, path: 'account', controllers: { registrations: 'users/registrations' }
  get '/account', to: 'account#show'
  
  resources :users, only: [:index, :show]

  post '/ds/event', to: 'd_s#event'
  get '/ds/dossiers', to: 'd_s#index'

  root "index#index"
end

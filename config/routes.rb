Rails.application.routes.draw do
  resources :administrations
  post '/administrations/:id/users', to: 'administrations#add_user', as: 'add_user_to_administration'
  delete '/administrations/:id/users/:user_id', to: 'administrations#remove_user', as: 'remove_user_from_administration'

  resources :signalements do
    member do
        post :publish
    end
  end
  
  devise_for :users, path: 'account', controllers: { registrations: 'users/registrations' }
  get '/account', to: 'account#show'
  
  resources :users, only: [:index, :show, :update]

  post '/ds/event', to: 'ds#event'
  get '/ds/dossiers', to: 'ds#index'

  get '/srj/nataffs', to: 'srj#nataffs'
  get '/srj/natinfs', to: 'srj#natinfs'

  root "index#index"
end

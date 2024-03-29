Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/trains' => 'trains#index', as: :trains
      get '/trains/:train_number' => 'trains#show', as: :train

      get '/reservations/:booking_code' => 'reservations#show', as: :reservation
      post '/reservations' => 'reservations#create', :as => :create_reservations
      patch '/reservations/:booking_code' => 'reservations#update', as: :update_reservation
      delete '/reservations/:booking_code' => 'reservations#destroy', as: :cancel_reservation
      get '/reservations' => 'reservations#index', as: :reservations
      post '/signup' => 'auth#signup'
      post '/login' => 'auth#login'
      post '/logout' => 'auth#logout'

      get '/me' => 'users#show', as: :user
      patch '/me' => 'users#update', as: :update_user
    end
  end
  resources :cities do
    member do
      post :update_temp
    end
  end
end

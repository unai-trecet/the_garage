Rails.application.routes.draw do

  root 'garages#new'

  resources :garages, only: [:new, :create, :show]
  post 'parking_vehicle', to: 'garages#park_vehicle'
  post 'find_vehicle', to: 'garages#find_vehicle'

  resources :vehicles, only: [:create]
end

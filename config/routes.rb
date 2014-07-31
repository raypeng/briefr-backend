Rails.application.routes.draw do

  root to: "categories#index"

  resources :stories

  get 'categories/:name', to: 'categories#show'

  get 'stories/:token', to: 'stories#show'
  
end

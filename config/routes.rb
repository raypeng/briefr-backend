Rails.application.routes.draw do

  root to: "stories#index"

  get 'categories/:name', to: 'categories#show'

  get 'stories/:token', to: 'stories#show'
  
end

Rails.application.routes.draw do

  root to: "stories#index"

  resources :stories

  get 'categories/:name', to: 'categories#show'

  get 'stories/:token', to: 'stories#show'

  # get 'review', to: 'stories#edit'
  
end

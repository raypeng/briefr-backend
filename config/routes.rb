Rails.application.routes.draw do

  root to: "stories#index"

  get 'categories/:name', to: 'categories#show'
  
end

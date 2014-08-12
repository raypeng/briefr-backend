Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "categories#index"

  resources :stories

  get 'categories/:name', to: 'categories#show'

  get 'stories/:token', to: 'stories#show'

  get 'stories/:token/show_index', to: 'stories#show_index'
  
end

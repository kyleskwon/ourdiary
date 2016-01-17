Rails.application.routes.draw do
  resources :items
  resources :plans
  resources :memories
  devise_for :users
  get 'homebase/index'
  root to: "homebase#index"
end

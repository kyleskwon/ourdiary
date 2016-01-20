Rails.application.routes.draw do
  devise_for :users
  resources :items
  resources :plans
  resources :memories
  resources :charges, only: [:new, :create]

  get 'charges/downgrade', as: :downgrade

  get 'homebase/index'
  root to: "homebase#index"
end

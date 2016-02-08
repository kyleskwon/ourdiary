Rails.application.routes.draw do
  get 'labels/show'

  devise_for :users
  resources :items
  resources :plans
  resources :memories
  resources :charges, only: [:new, :create]
  resources :labels, only: [:show]

  post "users/:user_id/confirm_partner/:id", to: "users#confirm_partner", as: :confirm_partner

  get 'charges/downgrade', as: :downgrade

  get 'homebase/index'
  root to: "homebase#index"
end

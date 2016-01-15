Rails.application.routes.draw do
  devise_for :users
  get 'homebase/index'
  root to: "homebase#index"
end

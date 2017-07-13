Rails.application.routes.draw do
  devise_for :users, path: 'user'

  resources :users, only: %i[index destroy]

  root 'users#index'
end

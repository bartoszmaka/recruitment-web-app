Rails.application.routes.draw do
  devise_for :users, path: 'user'

  resources :users, only: %i[index destroy]

  resources :admins, only: :index, path: 'admin_panel'

  root 'users#index'
end

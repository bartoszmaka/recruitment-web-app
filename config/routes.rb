Rails.application.routes.draw do
  devise_for :users, path: 'user'

  resources :users, except: :show

  resources :admins, only: :index, path: 'admin_panel'

  resources :regards, only: :create

  # post '/regards/:id', to: 'regards#create', as: :regards

  # get 'send_regards/:id', to: 'users#send_regards', as: :send_regards

  root 'users#index'
end

Rails.application.routes.draw do
  root 'projects#index'
  
  resources :projects do
    resources :tickets
  end
  
  devise_for :users
  
  namespace :account do
    resource :email, only: [:edit, :update]
    resource :password, only: [:edit, :update]
  end
end

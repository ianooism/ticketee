Rails.application.routes.draw do
  root 'projects#index'
  
  resources :projects do
    resources :tickets
  end
  
  devise_for :users, skip: [:registrations, :passwords]
  devise_scope :user do
    resource :password, only: [:new, :create, :edit, :update],
      as: 'user_password_reset',
      path: 'users/password_reset',
      controller: 'devise/passwords'
    namespace :users, as: 'user' do
      resource :registration, only: [:new, :create]
      resource :email, only: [:edit, :update]
      resource :password, only: [:edit, :update]
    end
  end
end

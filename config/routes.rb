Rails.application.routes.draw do
  root 'projects#index'
  
  resources :projects do
    resources :tickets
  end
  
  devise_for :users, skip: [:registrations, :passwords]
  devise_scope :user do
    resource :registration,
      as: 'user_registration',
      only: [:new, :create],
      path: 'users',
      controller: 'devise/registrations'
    resource :password,
      as: 'user_password_reset',
      only: [:new, :create, :edit, :update],
      path: 'users/password_reset',
      controller: 'devise/passwords'
    namespace :users, as: 'user' do
      resource :email, only: [:edit, :update]
      resource :password, only: [:edit, :update]
    end
  end
end

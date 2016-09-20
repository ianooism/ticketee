Rails.application.routes.draw do
  root 'projects#index'
  
  resources :projects do
    resources :tickets
  end
  
  resources :tickets, only: [] do
    resources :comments, only: [:create]
  end
  
  devise_for :users, skip: [:registrations, :passwords]
  devise_scope :user do
    namespace :users, as: 'user' do
      resource :email, only: [:edit, :update]
      resource :password, only: [:edit, :update]
      resource :reconfirmation, only: [:new, :create]
    end
    get 'users/sign_up', to: 'users/registrations#new', as: 'new_user_registration'
    post 'users/sign_up', to: 'users/registrations#create', as: 'user_registration'
    resource :password_reset, only: [:new, :create, :edit, :update],
      as: 'user_password_reset',
      path: 'users/password_reset',
      controller: 'devise/passwords'
  end
end

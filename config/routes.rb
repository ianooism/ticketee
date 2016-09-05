Rails.application.routes.draw do
  resources :tickets
  root 'projects#index'
  resources :projects
end

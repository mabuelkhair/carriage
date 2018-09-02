Rails.application.routes.draw do
  resources :users
  namespace :admin do
    resources :lists
  end
  namespace :user do
    resources :lists, :only => [:show, :index] 
  end
  post 'login', to: 'authentication#login'
end

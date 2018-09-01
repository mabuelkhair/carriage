Rails.application.routes.draw do
  resources :users
  namespace :admin do
    resources :lists
  end
  post 'login', to: 'authentication#login'
end

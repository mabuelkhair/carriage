Rails.application.routes.draw do
  resources :users
  namespace :admin do
    resources :lists do
      member do 
        post 'assign_member'
        delete 'unassign_member'
      end
    end
  end
  namespace :user do
    resources :lists, :only => [:show, :index] 
  end
  post 'login', to: 'authentication#login'
end

Rails.application.routes.draw do
  resources :users

  namespace :admin do
    resources :lists do
      member do 
        post 'assign_member'
        delete 'unassign_member'
      end
      resources :cards do
        resources :comments
      end
    end
  end

  namespace :user do
    resources :lists, :only => [:show, :index] do
      resources :cards
    end
  end
  post 'login', to: 'authentication#login'
end

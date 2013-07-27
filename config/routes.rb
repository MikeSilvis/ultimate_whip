UltimateWhip::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  namespace "api" do ## Used for Ajax purposes
    namespace "v1" do
      resources :comments
      resources :garages
      resources :tags, only: [:index]
      resources :photos do
        collection do
          get "file_name"
        end
      end
    end
  end

  resources :photos, only: [:show,:new, :index]
  resources :tags, only: [:show, :new]
  resources :landings, only: [:show]

  resources :garages
  resources :garage_photos
  resources :makes, only: [:show]
  resources :registration_succesful, only: [:index]
  resources :users, only: [:update]
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root :to => "whips#index"
  ActiveAdmin.routes(self)

end

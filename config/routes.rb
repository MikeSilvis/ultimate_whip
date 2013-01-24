UltimateWhip::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :garages
  namespace "api" do ## Used for Ajax purposes
    namespace "v1" do
      resources :comments
      resources :tags
      resources :photos do
        collection do
          get "file_name"
        end
      end
    end
  end
  resources :photos, only: [:show,:new]
  resources :garage_photos
  resources :makes, only: [:show]
  root :to => "whips#index"
  devise_for :users
end

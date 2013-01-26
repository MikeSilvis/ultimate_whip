UltimateWhip::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  namespace "api" do ## Used for Ajax purposes
    namespace "v1" do
      resources :comments
      resources :tags
      resources :photos do
        collection do
          get 'pages/:page/tags/:tags', to: "photos#index"
          get "file_name"
        end
      end
    end
  end

  resources :photos, only: [:show,:new]
  resources :tags, only: [:show]

  resources :garages
  resources :garage_photos
  resources :makes, only: [:show]
  resources :registration_succesful, only: [:index]
  root :to => "whips#index"
  devise_for :users
end

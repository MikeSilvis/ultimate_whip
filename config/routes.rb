UltimateWhip::Application.routes.draw do
  resources :tags
  resources :users do
    collection do
      get "current"
    end
  end
  resources :garages
  resources :garage_photos
  resources :comments
  resources :photos do
    collection do
      get "file_name"
    end
  end

  resources :makes, only: [:show]
  root :to => "whips#index"
  devise_for :users

end
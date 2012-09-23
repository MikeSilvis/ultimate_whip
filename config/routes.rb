UltimateWhip::Application.routes.draw do
  resources :tags
  resources :garages
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
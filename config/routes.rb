UltimateWhip::Application.routes.draw do
  resources :garages
  resources :photos
  resources :makes, only: [:show]
  root :to => "whips#index"
  devise_for :users

end
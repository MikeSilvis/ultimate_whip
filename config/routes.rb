UltimateWhip::Application.routes.draw do
  resources :garages, only: [:show]
  resources :makes, only: [:show]
  root :to => "whips#index"
  devise_for :users

end
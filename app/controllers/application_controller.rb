class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(user)
    if user.sign_in_count == 1
      registration_succesful_index_path
    else
       root_path
    end
  end
end

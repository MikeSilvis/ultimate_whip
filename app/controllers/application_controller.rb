class ApplicationController < ActionController::Base
  protect_from_forgery
  cache_sweeper :tag_sweeper, :garage_photo_sweeper, :garage_sweeper
  before_filter :update_sanitized_params, if: :devise_controller?

  def after_sign_in_path_for(user)
    if user.sign_in_count == 1
      registration_succesful_index_path
    else
       root_path
    end
  end

  def expire_cache
    Tag.last.save
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :email, :password)}
  end

end

class ApiController < ActionController::Base

  def authenticate_user!
    if current_user.blank?
      render :json => {}, :status => :unauthorized
      return false
    end
  end

end

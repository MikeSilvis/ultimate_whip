class ApiController < ActionController::Base
  # super to make sure if the user is logged in via session, we honor that.
  def current_user
    User.find_by_token(params[:token]) || super
  end

  def authenticate_user!
    if current_user.blank?
      render :json => {}, :status => :unauthorized
      return false
    end
  end
end

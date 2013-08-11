class UsersController < ApplicationController

	before_filter :authenticate_user!, only: [:update]

  def update
    Thread.new { current_user.update_attributes(params[:user].permit!) }
    render json: true
  end

end

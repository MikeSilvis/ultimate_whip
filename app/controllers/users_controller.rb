class UsersController < ApplicationController
  before_filter :authenticate_user!
  def current
    render json: current_user
  end
end

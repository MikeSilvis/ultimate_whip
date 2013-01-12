class PhotosController < ApplicationController

  before_filter :authenticate_user!, only: [:new]
  before_filter :require_ride, only: :new
  # redirects for facebook and twitter sharing purposes
  def show
    redirect_to "/#/photos/#{params[:id]}"
  end

  def new

  end

  def require_ride
    redirect_to new_garage_path, :alert => "You must have a vehicle first" unless (current_user.vehicles.size > 0)
  end

end

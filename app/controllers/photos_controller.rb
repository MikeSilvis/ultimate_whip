class PhotosController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :index]
  before_filter :require_ride, only: :new

  def index
  end

  def show
    render "whips/index"
  end

  def new
  end

private

  def photos
    @photos ||= current_user.photos.includes(:tags)
  end
  helper_method :photos

  def require_ride
    redirect_to new_garage_path, :alert => "You must have a vehicle first" unless (current_user.vehicles.size > 0)
  end

end

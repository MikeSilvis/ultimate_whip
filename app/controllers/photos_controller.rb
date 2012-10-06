class PhotosController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!, only: :create
  before_filter :require_yours, only: :destroy
  before_filter :require_ride, only: :new

  def index
    render json: GaragePhoto.find_all(params[:index], params[:tags]).limit(40).all, root: false
  end

  def show
    render json: GaragePhoto.find_one(params[:id]), root: false, :serializer => PhotoFullSerializer
  end

  def new

  end

  def create
    @photo = GaragePhoto.create(photo: params[:file], garage_id: params[:garage_id])
    @photo.create_default_tags
    render json: {created: true}
  end

  def destroy
    @photo.destroy
    render json: {destroyed: true}
  end

private

  def require_yours
    @photo = GaragePhoto.find(params[:id])
    redirect_to :root unless @photo.garage.user == current_user
  end

  def require_ride
    redirect_to new_garage_path, flash[:notice] => "You must have a vehicle first" unless current_user.vehicles
  end

end

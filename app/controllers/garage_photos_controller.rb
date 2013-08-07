class GaragePhotosController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!
  after_filter :expire_cache

  def create
    current_user.vehicles.find(params[:garage_photo][:garage_id]).photos.create(photo: params[:garage_photo][:photo])
    render json: true
  end

  def update
    GaragePhoto.find(params[:id]).update_attributes(params[:garage_photo])
    render json: true
  end

  def destroy
    current_user.photos.find(params[:id]).destroy
    render json: true
  end

end

class GaragePhotosController < ApplicationController
  before_filter :authenticate_user!
  def create
    @photo = Garage.find(params["garage_photo"]["garage_id"]).photos.create(photo: params["garage_photo"]["photo"])
    @photo.create_default_tags
  end
  def update
    @photo = GaragePhoto.find(params[:id])
    @photo.update_attributes(params[:garage_photo])
    render json: true
  end
end

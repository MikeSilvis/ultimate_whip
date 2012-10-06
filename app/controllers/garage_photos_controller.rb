class GaragePhotosController < ApplicationController
  protect_from_forgery except: :create
  def create
    @photo = Garage.find(params["garage_photo"]["garage_id"]).photos.create(photo: params["garage_photo"]["photo"])
    # @photo.create_default_tags
  end

end

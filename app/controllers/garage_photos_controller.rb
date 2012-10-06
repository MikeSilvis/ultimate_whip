class GaragePhotosController < ApplicationController
  protect_from_forgery except: :create
  def create
    @photo = GaragePhoto.last
    # @photo = Garage.find(params[:garage_id]).photos.create(photo:params[:file])
    # @photo.create_default_tags
  end

end

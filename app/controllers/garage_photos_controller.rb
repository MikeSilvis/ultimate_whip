class GaragePhotosController < ApplicationController
  def create
    @photo = GaragePhoto.create(photo: params[:garage_photo])
    @photo.create_default_tags
    render json: {created: true}
  end
end

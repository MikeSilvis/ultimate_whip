class PhotosController < ApplicationController
  def index
    render json: GaragePhoto.all, root: false
  end

  def new

  end

  def create
    GaragePhoto.create(photo: params[:file], garage_id: params[:garage_id])
    render json: {created: true}
  end
end

class PhotosController < ApplicationController
  def index
    render json: GaragePhoto.includes(:garage).all, root: false
  end

  def new

  end

  def create
    GaragePhoto.create(photo: params[:file], garage_id: Garage.last.id)
    render json: {created: true}
  end
end

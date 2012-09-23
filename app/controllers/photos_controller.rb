class PhotosController < ApplicationController
  def index
    render json: GaragePhoto.find_all(params[:index] || 0).limit(40).all, root: false
  end

  def show
    render json: GaragePhoto.find_one(params[:id]), root: false
  end

  def new

  end

  def create
    GaragePhoto.create(photo: params[:file], garage_id: Garage.last.id)
    render json: {created: true}
  end
end

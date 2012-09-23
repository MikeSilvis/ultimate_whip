class PhotosController < ApplicationController
  def index
    render json: GaragePhoto.find_all, root: false
  end

  def show
    render json: GaragePhoto.find_one(params[:id]), root: false
  end

  def new

  end

  def create
    Thread.new do
      GaragePhoto.create(photo: params[:file], garage_id: Garage.last.id)
    end
    render json: {created: true}
  end
end

class PhotosController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!, only: :create

  def index
    render json: GaragePhoto.find_all(params[:index], params[:tags]).limit(40).all, root: false
  end

  def show
    render json: GaragePhoto.find_one(params[:id]), root: false, :serializer => PhotoFullSerializer
  end

  def file_name
    render json: GaragePhoto.find_by_file_name(params[:name]), root: false
  end

  def new

  end

  def create
    GaragePhoto.create(photo: params[:file], garage_id: params[:garage_id])
    render json: {created: true}
  end
end

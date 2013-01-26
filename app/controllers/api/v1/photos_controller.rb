class Api::V1::PhotosController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!, only: [:create, :new]
  before_filter :require_yours, only: :destroy

  caches_page :index, :show, :cache_path => Proc.new { |c| c.params }

  def index
    render json: GaragePhoto.find_all(params[:page], params[:tags]).to_a, root: false
  end

  def show
    render json: GaragePhoto.find_one(params[:id]), root: false, :serializer => PhotoFullSerializer
  end

private

  def require_yours
    @photo = GaragePhoto.find(params[:id])
    redirect_to :root unless @photo.garage.user == current_user
  end

end

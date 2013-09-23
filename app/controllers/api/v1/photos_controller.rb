class Api::V1::PhotosController < ApiController
  protect_from_forgery except: :create
  before_filter :authenticate_user!, only: [:create, :new]
  before_filter :require_yours, only: :destroy

  def show
    render json: GaragePhoto.find(params[:id]), serializer: PhotoFullSerializer
  end

private

  def require_yours
    @photo = GaragePhoto.find(params[:id])
    redirect_to :root unless @photo.garage.user == current_user
  end

end

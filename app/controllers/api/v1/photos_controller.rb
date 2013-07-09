class Api::V1::PhotosController < ApiController
  protect_from_forgery except: :create
  before_filter :authenticate_user!, only: [:create, :new]
  before_filter :require_yours, only: :destroy

  caches_action :index, :cache_path => Proc.new { |c| c.params }
  caches_page :show

  def show
    render json: GaragePhoto.find(params[:id]), root: false, serializer: PhotoFullSerializer
  end

private

  def require_yours
    @photo = GaragePhoto.find(params[:id])
    redirect_to :root unless @photo.garage.user == current_user
  end

end

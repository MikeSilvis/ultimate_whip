class Api::V1::GaragesController < ApplicationController

  caches_action :index, :cache_path => Proc.new { |c| c.params }

  def index
    render json: Garage.find_all(params[:page], params[:tags]), root: false
  end

end

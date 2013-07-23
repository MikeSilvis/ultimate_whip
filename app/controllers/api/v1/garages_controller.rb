require "open-uri"

class Api::V1::GaragesController < ApplicationController
  before_filter :require_api_key, only: [:update]

  caches_action :index, :cache_path => Proc.new { |c| c.params }

  def index
    render json: Garage.find_all(params[:page], params[:tags]), root: false
  end

  def update
    g = Garage.where(id: params[:id]).includes(:photos).first
    before_count = g.photos.count
    params[:images].each do |k,img|
      g.photos.where(original_url: img).first_or_create(photo: open(img)).save rescue nil
    end
    render json: { images_requested: params[:images].count, images_saved: (g.photos.count - before_count) }
  end

private


  def require_api_key
    render json: false unless params[:api] == "mikeisawesome"
  end

end

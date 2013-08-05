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
      Thread.new { g.photos.where(original_url: k).first_or_create(photo: open(k)).save }
    end
    flash[:success] = 'Photos Will be uploaded shortly'
    render json: { images_requested: params[:images].count, images_saved: (g.photos.count - before_count) }
  end

private


  def require_api_key
    if current_user.blank?
      render json: false unless params[:api] == "mikeisawesome"
    end
  end

end

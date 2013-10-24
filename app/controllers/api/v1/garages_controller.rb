require "open-uri"

class Api::V1::GaragesController < ApplicationController
  before_filter :require_api_key, only: [:update]

  def index
    render json: Garage.find_all(params[:page], params[:tags])
  end

  def update
    g = Garage.where(id: params[:id]).includes(:photos).first
    before_count = g.photos.count
    threads = []
    params[:images].each do |k,img|
      threads << Thread.new { g.photos.where(original_url: img).first_or_create(photo: open(img)).save }
    end
    threads.map(&:join)
    render json: { images_requested: params[:images].count, images_saved: (g.photos.count - before_count) }
  end

private


  def require_api_key
    if current_user.blank?
      render json: false unless params[:api] == "mikeisawesome"
    end
  end

end

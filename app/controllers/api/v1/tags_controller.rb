class Api::V1::TagsController < ApplicationController
  caches_action :index

  def index
    render json: Tag.order(:name), root: false
  end

end

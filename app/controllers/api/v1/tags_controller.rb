class Api::V1::TagsController < ApplicationController
  def index
    render json: Tag.order(:name), root: false
  end
end

class TagsController < ApplicationController
  def index
    render json: Tag.order(:name).all, root: false
  end
end

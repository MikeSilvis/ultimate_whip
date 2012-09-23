class TagsController < ApplicationController
  def index
    render json: Tag.all, root: false
  end
end

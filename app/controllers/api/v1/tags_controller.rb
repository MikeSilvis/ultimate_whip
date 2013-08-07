class Api::V1::TagsController < ApiController

  def index
    render json: Tag.order(:name), root: false
  end

end

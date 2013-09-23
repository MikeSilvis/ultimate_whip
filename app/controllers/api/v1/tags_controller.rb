class Api::V1::TagsController < ApiController

  def index
    render json: Tag.order(:name)
  end

end

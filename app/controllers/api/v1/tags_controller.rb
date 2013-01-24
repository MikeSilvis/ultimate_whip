class Api::V1::TagsController < ApiController
  caches_page  :index

  def index
    render json: Tag.order(:name), root: false
  end

end

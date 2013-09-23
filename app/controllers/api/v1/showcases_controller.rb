class Api::V1::ShowcasesController < ApplicationController

  def index
    render json: Showcase.find_with_tag(params[:tag_name])
  end

end

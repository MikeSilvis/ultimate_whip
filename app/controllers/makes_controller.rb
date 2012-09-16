class MakesController < ApplicationController
  def show
    render json: Make.find_with_graph(params[:id]), root: false
  end
end

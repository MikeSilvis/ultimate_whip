class GaragesController < ApplicationController
  def show
    render json: Garage.find_with_graph(params[:id]), root: false
  end
end

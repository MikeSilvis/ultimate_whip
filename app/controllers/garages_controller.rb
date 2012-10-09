class GaragesController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  def new
  end

  def show
    render json: Garage.find_with_graph(params[:id]), root: false
  end

end

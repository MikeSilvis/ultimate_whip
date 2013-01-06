class GaragesController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  def new
  end

  def create
    garage = current_user.vehicles.create(params[:garage])
    if garage.save
      redirect_to new_photo_path, notice: "Your vehicle has been created."
    else
      render "garages/new"
      flash[:alert] = "There was a problem saving your vehicle. The year is probably incorrect"
    end
  end

  def show
    render json: Garage.find_with_graph(params[:id]), root: false
  end

end

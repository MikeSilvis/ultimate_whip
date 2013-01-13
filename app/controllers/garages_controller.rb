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

  def update
    garage = current_user.vehicles.find(params[:id])
    garage.tag_list = params[:garage][:tag_list]
    if garage.save
      render status: 200, json: "true"
    end
  end

end

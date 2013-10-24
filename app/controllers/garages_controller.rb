class GaragesController < ApplicationController
  before_filter :authenticate_user!, only: [:new]
  after_filter :expire_cache, only: [:create]

  def new
  end

  def create
    garage = current_user.vehicles.create(params[:garage].permit!)
    if garage.save
      redirect_to new_photo_path, notice: "Your vehicle has been created."
    else
      flash[:alert] = "There was a problem saving your vehicle. Please try again"
      render "garages/new"
    end
  end

end

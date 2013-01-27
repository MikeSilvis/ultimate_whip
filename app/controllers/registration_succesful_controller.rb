class RegistrationSuccesfulController < ApplicationController
  def index
    flash[:success] = "Congratulations! Now please add your vehicle."
    redirect_to new_garage_path
  end
end

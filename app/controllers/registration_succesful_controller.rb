class RegistrationSuccesfulController < ApplicationController
  def index
    flash.keep
    redirect_to root_path
  end
end

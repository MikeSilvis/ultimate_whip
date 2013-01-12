class PhotosController < ApplicationController

  # redirects for facebook and twitter sharing purposes
  def show
    redirect_to "/#/photos/#{params[:id]}"
  end

end

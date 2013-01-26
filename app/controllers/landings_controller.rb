class LandingsController < ApplicationController
  def show
    @landing = Landing.find_by_slug(params[:id])
    render layout: "landing_application"
  end
end

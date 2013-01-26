module LandingsHelper
  def latest_photos
    GaragePhoto.order("created_at DESC").limit(4)
  end
end

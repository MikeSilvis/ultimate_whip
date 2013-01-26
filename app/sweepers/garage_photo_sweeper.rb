class GaragePhotoSweeper < ActionController::Caching::Sweeper
  observe GaragePhoto

  def sweep(photo)
    expire_page "/api/v1/photos/#{photo.id}"
    expire_fragment(%r{views\/localhost:3000\/api\/v1\/photos\?&page=\d})
  end

  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end

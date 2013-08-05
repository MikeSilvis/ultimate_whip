class GarageSweeper < ActionController::Caching::Sweeper
  observe Garage

  def sweep(garage)
    expire_fragment(%r{api\/v1\/garages\?page=\d})
  end

  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end

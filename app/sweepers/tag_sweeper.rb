class TagSweeper < ActionController::Caching::Sweeper
  observe Tag

  def sweep(tag)
    #expire_page "/api/v1/tags"
  end

  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end

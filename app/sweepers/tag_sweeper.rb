class TagSweeper < ActionController::Caching::Sweeper
  observe Tag

  def sweep(tag)
    expire_action(:controller => "api_v1_tags", :action => "index")
  end

  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end

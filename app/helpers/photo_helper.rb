module PhotoHelper
  def current_tab?(current)
    true if current == params[:action]
  end
end

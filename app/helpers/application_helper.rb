module ApplicationHelper
  def list_vehicles
    current_user.vehicles.includes(:model) if current_user
  end

  def list_vehicles_by_name
    list_vehicles.map { |v| [v.shortened_name, v.id]}
  end

end

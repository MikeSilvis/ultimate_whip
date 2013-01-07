module GarageHelper

  def new_car
    Garage.new
  end

  def all_makes_order_by_name
    Make.all_ordered_by_name
  end

end

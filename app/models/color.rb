class Color < ActiveRecord::Base
  attr_accessible :name
  has_many :garages

  def self.create_from_yaml
    CreateCars.colors.each do |color|
      Color.find_or_create_by_name(color["name"])
    end
  end

  def cars_with_color
    #color.   
  end
end

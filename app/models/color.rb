class Color < ActiveRecord::Base
  attr_accessible :name

  def self.create_from_yaml
    CreateCars.colors.each do |color|
      Color.find_or_create_by_name(color["name"])
    end
  end
end

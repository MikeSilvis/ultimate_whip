class Color < ActiveRecord::Base
  has_many :garages

  def self.create_from_yaml
    CreateCars.colors.each do |color|
      Color.find_or_create_by_name(color["name"])
    end
  end

end

class Make < ActiveRecord::Base
  has_many :models


  def self.all_ordered_by_name
    Make.includes(:models).order("name")
  end

  def self.create_makes_from_yaml
    CreateCars.normalize_makes.each do |make|
      Make.find_or_create_by_name_and_id(make[:name], make[:id])
    end
  end

end

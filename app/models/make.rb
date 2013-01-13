class Make < ActiveRecord::Base
  attr_accessible :model_id, :name
  has_many :models

  def self.find_with_graph(id)
    where(id: id).joins(:type, :model).first
  end

  def self.all_ordered_by_name
    Make.order("name")
  end

  def self.create_makes_from_yaml
    CreateCars.normalize_makes.each do |make|
      Make.find_or_create_by_name_and_id(make[:name], make[:id])
    end
  end

end

class Make < ActiveRecord::Base
  attr_accessible :model_id, :name, :type_id
  has_many :models

  def self.find_with_graph(id)
    where(id: id).joins(:type, :model).first
  end

  def self.all_ordered_by_name
    Make.order("name")
  end

  def self.create_makes_from_yaml
    makes_from_yaml.each do |make|
      Make.find_or_create_by_name_and_id(make[:name], make[:id])
    end
  end

  def self.makes_from_yaml
    CreateCars.normalize_makes
  end

end

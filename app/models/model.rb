class Model < ActiveRecord::Base
  attr_accessible :name, :make, :make_id
  belongs_to :make

  def self.create_from_yaml
    Make.create_makes_from_yaml
    Color.create_from_yaml
    normalized_models_from_yaml.each do |model|
      begin
        make = Make.find model[:make_id]
        Model.find_or_create_by_name_and_make_id(model[:name].to_s, make.id) if make
      end
    end
  end

  def self.normalized_models_from_yaml
    CreateCars.normalize_models
  end
end

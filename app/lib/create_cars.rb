require 'yaml'
class CreateCars

  class << self
    def normalize_makes
      makes.collect do |make|
        { name: make["Make"], id: make["Make_ID"] }
      end
    end

    def normalize_models
      normalized = []
      models.each do |model|
        normalized << { name: model["Model"], make_id: model["Make_ID"] } if valid_type_and_make? model
      end
      normalized
    end

    def valid_type_and_make?(model)
      (model["Type_ID"] == 1) && (make_ids.include?(model["Make_ID"]))
    end

    def make_ids
      @make_ids ||= normalize_makes.map { |make| make[:id] }
    end

    def makes
      @makes ||= YAML::load(File.open(File.expand_path("../../../lib/assets/vehicles/Vehicle_Make.yml", __FILE__)))
    end

    def models
      @models ||= YAML::load(File.open(File.expand_path("../../../lib/assets/vehicles/Vehicle_Model.yml", __FILE__)))
    end

  end

end

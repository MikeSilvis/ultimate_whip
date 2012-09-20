class GarageSerializer < ActiveModel::Serializer
  attributes :id, :year, :color_name, :make_name, :model_name

  def color_name
    self.color.name
  end

  def make_name
    self.model.make.name
  end

  def model_name
    self.model.name
  end

  has_one :model
  has_one :color

end

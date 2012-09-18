class ModelSerializer < ActiveModel::Serializer
  attributes :id, :name, :updated_at, :make_name
  has_one :make

  def make_name
    self.make.name
  end

end

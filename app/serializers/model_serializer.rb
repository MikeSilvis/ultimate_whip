class ModelSerializer < ActiveModel::Serializer
  attributes :id, :name, :updated_at

  has_one :make
end

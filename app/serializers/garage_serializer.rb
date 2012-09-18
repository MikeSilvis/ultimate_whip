class GarageSerializer < ActiveModel::Serializer
  attributes :id, :year
  has_one :model
  has_one :color
  has_one :user
  has_many :tags
end

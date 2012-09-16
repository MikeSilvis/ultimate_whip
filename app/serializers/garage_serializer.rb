class GarageSerializer < ActiveModel::Serializer
  attributes :id, :year
  has_one :make
  has_one :color
  has_one :user
  has_many :tags
end

class GarageSerializer < ActiveModel::Serializer
  attributes :id, :year, :updated_at

  has_one :model
  has_one :user
  has_one :color
  has_many :photos
  #has_many :tags

end

class GarageSerializer < ActiveModel::Serializer
  cached
  attributes :id, :year, :updated_at, :added_content

  has_one :model
  has_one :user
  has_one :color
  has_many :photos

  def cache_key
    [object]
  end
end

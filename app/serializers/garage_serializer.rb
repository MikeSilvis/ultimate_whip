class GarageSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :year, :updated_at, :updated_at_short

  def updated_at_short
    time_ago_in_words self.updated_at
  end

  has_one :model
  has_one :user
  has_one :color
  has_many :photos
  #has_many :tags

end

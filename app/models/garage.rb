class Garage < ActiveRecord::Base
  attr_accessible :color, :year, :user, :model
  belongs_to :user
  belongs_to :model
  belongs_to :color
  has_many :garage_tags
  has_many :tags, :through => :garage_tags
  has_many :photos, class_name: "GaragePhoto"

  def self.find_with_graph(id)
    where(id: id).joins(:color, :user).includes(:tags).first
  end

end

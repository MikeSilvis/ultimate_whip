class Garage < ActiveRecord::Base
  attr_accessible :color, :year, :user, :model
  belongs_to :user
  belongs_to :model
  belongs_to :color
  has_many :photos, class_name: "GaragePhoto"

  delegate :username, to: :user
  validates_presence_of :user

  def self.find_with_graph(id)
    where(id: id).joins(:color, :user).first
  end

  def shortened_name
    "#{self.year} #{model.name}"
  end

end

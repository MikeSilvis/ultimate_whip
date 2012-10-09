class Garage < ActiveRecord::Base
  attr_accessible :color, :year, :user, :model, :make_id, :model_id, :color_id
  belongs_to :user
  belongs_to :model
  belongs_to :color
  has_many :photos, class_name: "GaragePhoto"

  delegate :username, :secret_hash, to: :user
  validates_presence_of :user
  validates_length_of :year, :within => 4..4, :on => :create, :message => "What kinda year is that?"

  def self.find_with_graph(id)
    where(id: id).joins(:color, :user).first
  end

  def shortened_name
    "#{self.year} #{model.name}"
  end

end

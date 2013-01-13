class Garage < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :color, :year, :user, :model, :make_id, :model_id, :color_id, :tag_list
  belongs_to :user
  belongs_to :model
  belongs_to :color
  has_one :default_tag
  has_many :photos, class_name: "GaragePhoto"

  delegate :username, :secret_hash, to: :user
  validates_presence_of :user, :model, :year
  before_create :create_default_tag
  validates_length_of :year, :within => 4..4, :on => :create, :message => "What kinda year is that?"

  def self.find_with_graph(id)
    where(id: id).joins(:color, :user).first
  end

  def shortened_name
    "#{self.year} #{model.name}"
  end

  def create_default_tags
    self.tag_list = "#{color.name}, #{model.name}, #{model.make.name}, #{year}"
  end

end

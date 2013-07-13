class Garage < ActiveRecord::Base
  acts_as_taggable
  acts_as_commentable
  attr_accessible :color, :year, :user, :model, :model_id, :color_id
  belongs_to :user
  belongs_to :model
  belongs_to :color
  has_many :photos, class_name: "GaragePhoto", order: 'created_at DESC'
  #has_many :photos, -> { order('updated_at DESC') }, class_name: 'GaragePhoto'

  before_create :create_default_tags
  delegate :username, :secret_hash, to: :user
  validates_presence_of :user
  validates_length_of :year, :within => 4..4, :on => :create, :message => "What kinda year is that?"

  def shortened_name
    "#{self.year} #{model.name}"
  end

  def self.find_all(page, tags)
    query = select("DISTINCT on (garages.updated_at, garages.id) garages.*")
      .joins("JOIN garage_photos on garages.id = garage_photos.garage_id")
      .joins("JOIN taggings on garage_photos.id = taggings.taggable_id")
      .joins("JOIN tags on tags.id = taggings.tag_id")
      .page(page)
      .order("garages.updated_at DESC")
      .where("taggings.taggable_type = ?", "GaragePhoto")
      .includes(:photos)
    query = query.where("(lower(tags.name) IN (?))", tags) if tags
    query
  end

  def create_default_tags
    self.tag_list = [year, model.name, model.make.name, username].join(", ")
  end

  def make
    model.make
  end

  def make_name
    make.name
  end

  def model_name
    model.name
  end
end

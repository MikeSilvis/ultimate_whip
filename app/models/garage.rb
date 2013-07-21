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
    query = Garage.page(page).order("garages.updated_at DESC").includes(:photos).includes(:color, :user, { model: :make }).joins(:photos)
    query = query.where(id: GaragePhoto.select("DISTINCT(garage_id)").tagged_with(tags)) if tags
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

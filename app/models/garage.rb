class Garage < ActiveRecord::Base
  acts_as_taggable
  acts_as_commentable
  attr_accessor :forum_urls, :forum_div
  belongs_to :user
  belongs_to :model
  belongs_to :color
  has_many :photos, -> { order('created_at DESC') }, class_name: "GaragePhoto"
  accepts_nested_attributes_for :photos, allow_destroy: true

  before_create :create_default_tags
  before_save :bulk_upload_photos, if: Proc.new { |garage| garage.forum_urls.present? && garage.forum_div.present? }
  delegate :username, :secret_hash, to: :user
  validates_presence_of :user, :color, :model
  validates_length_of :year, :within => 4..4, :on => :create, :message => "What kinda year is that?"

  def shortened_name
    "#{self.year} #{model.name}"
  end

  def self.find_all(page, tags)
    query = Garage.includes(:photos, :color, :user, { model: :make }).order("garages.added_content ASC, garages.updated_at DESC").joins(:photos).page(page)
    query = query.tagged_with(tags, wild: true) if tags
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

private

  def bulk_upload_photos
    client = IronWorkerNG::Client.new
    client.tasks.create('ImageWorker', { urls: self.forum_urls.split(",").map(&:strip), div: forum_div, id: self.id })
  end

end

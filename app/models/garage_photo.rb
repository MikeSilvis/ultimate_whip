class GaragePhoto < ActiveRecord::Base
  require "open-uri"
  acts_as_taggable
  acts_as_likeable
  acts_as_commentable
  attr_accessible :garage_id, :photo, :tag_list

  belongs_to :garage
  delegate :username, :user_id, :secret_hash, :user, to: :garage

  has_attached_file :photo,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :styles => {
                    :large => "1200x900",
                    :thumb => "200x200#"
                 }

  def photo_url_thumb
    photo.url(:thumb)
  end

  def photo_url_large
    photo.url(:large)
  end

  def like_count
    likers(User).size
  end

  def likes
    @likes ||= likers(User)
  end

  def create_default_tags
    self.tag_list = "#{self.garage.year}, #{self.garage.model.name}, #{self.garage.model.make.name}, #{self.garage.color.name}, #{self.username}"
    self.save
  end

  def like_count
    likes.size
  end

  def self.find_all(index, tags)
    query = self
    query = where("garage_photos.id < ?", index.to_i) if index
    query = query.includes(:tags).tagged_with(tags.split(",")) if tags
    query
  end

  def self.find_one(id)
    includes_for_json.where(id: id).first
  end

  def self.find_by_file_name(name)
    includes_for_json.where(photo_file_name: name).order("created_at DESC").first
  end

  def self.includes_for_json
    self.includes(:garage, :tags, :comments)
  end

end

class GaragePhoto < ActiveRecord::Base
  require "open-uri"
  acts_as_taggable
  acts_as_likeable
  acts_as_commentable
  attr_accessible :garage_id, :photo

  belongs_to :garage
  delegate :username, :user_id, to: :garage

  has_attached_file :photo,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :styles => {
                    :large => "1200x900",
                    :thumb => "200x270"
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

  def self.find_all(index, tags)
    query = order("garage_photos.created_at DESC")
    query = query.where("garage_photos.id < ?", index.to_i) if index
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

class GaragePhoto < ActiveRecord::Base
  require "open-uri"
  acts_as_taggable
  acts_as_likeable
  attr_accessible :garage_id, :photo

  belongs_to :garage
  delegate :username, to: :garage

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

end

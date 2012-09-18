class GaragePhoto < ActiveRecord::Base
  require "open-uri"

  attr_accessible :garage_id, :photo

  belongs_to :garage
  has_many :photo_tags
  has_many :tags, through: :photo_tags

  has_attached_file :photo,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :styles => {
                    :large => "600x600",
                    :thumb => "200x270"
                 }

  def photo_url_thumb
    photo.url(:thumb)
  end

  def photo_url_large
    photo.url(:large)
  end

end

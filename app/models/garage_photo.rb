class GaragePhoto < ActiveRecord::Base
  require "open-uri"
  acts_as_taggable
  acts_as_likeable
  acts_as_commentable
  attr_accessible :garage_id, :photo, :tag_list, :photo
  before_create :create_default_tags

  belongs_to :garage, touch: true
  has_one :model, through: :garage
  delegate :username, :user_id, :secret_hash, :user, to: :garage
  delegate :make_name, :model_name, to: :garage

  has_attached_file :photo,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :styles => {
      :large => "1200x900",
      :thumb => "100x100#",
      :wide => "100x50"
    }

    def self.find_all(page, tags)
      query = self.order("created_at DESC").includes(:tags, :garage)
      query = query.tagged_with(tags.split(",")) if tags.present
      query
    end

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
      self.tag_list = default_tags
    end

    def default_tags
      self.garage.tag_list
    end

    def like_count
      likes.size
    end

    def tags_string
      tags.join(", ")
    end

    def self.find_by_file_name(name)
      includes_for_json.where(photo_file_name: name).order("created_at DESC").first
    end

    def self.create_photos_from_blog(url, garage_id)
      images = ImageScrapper.new(url).find_all_images
      images.each do |img|
        begin
          GaragePhoto.where(:original_url => img, :garage_id => garage_id).first_or_create(:photo => open(img)).save
        end
      end
      GaragePhotoSweeper.send(:new).sweep(GaragePhoto.last)
      TagSweeper.send(:new).sweep(Tag.last)
    end

end

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
      self.tag_list = default_tags
      self.save
    end

    def default_tags
      "#{self.garage.year}, #{self.garage.model.name}, #{self.garage.model.make.name}, #{self.garage.color.name}, #{self.username}"
    end

    def like_count
      likes.size
    end

    def tags_string
      tags.join(", ")
    end

    def self.find_all(page, tags)
      if tags
        order("created_at DESC").includes(:tags).tagged_with(tags.split(",")).page(page)
      else
        order("created_at DESC").includes(:tags).page(page)
      end
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

    def self.create_photos_from_blog(url, garage_id)
      images = ImageScrapper.new(url).find_all_images
      images.each do |img|
        photo = open(img)
        begin
          gp = GaragePhoto.where(:original_url => img, :garage_id => garage_id).first_or_create(:photo => photo)
          g = Garage.find_by_id(garage_id)
          gp.tag_list = "#{g.username}, #{gp.default_tags}"
          gp.save
        end
      end
    end

end

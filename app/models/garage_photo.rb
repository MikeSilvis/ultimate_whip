class GaragePhoto < ActiveRecord::Base
  require "open-uri"
  #acts_as_taggable
  #acts_as_likeable
  acts_as_commentable

  belongs_to :garage, touch: true
  has_one :model, through: :garage
  delegate :username, :user_id, :secret_hash, :user, to: :garage
  delegate :make_name, :model_name, to: :garage
  after_create :incremented_added_content

  has_attached_file :photo,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :styles => {
      large:       "1200x900",
      featured:    "1200x300#",
      featured_iphone: "640x480#",
      thumb:       "80x80#",
      wide:        "100x50#"
    },
    convert_options: { thumb: "-quality 60" }

    def photo_url_thumb
      photo.url(:thumb)
    end

    def photo_thumb_wide
      photo.url(:wide)
    end

    def photo_url_large
      photo.url(:large)
    end

    def photo_featured_iphone
      photo.url(:featured_iphone)
    end

    def photo_featured
      photo.url(:featured_iphone)
    end

    def self.find_by_file_name(name)
      includes_for_json.where(photo_file_name: name).order("created_at DESC").first
    end

    def self.create_photos_from_blog(urls, div, garage_id)
      images = ImageScrapper.new(urls.uniq,div).find_all_images
      images.each do |img|
        begin
          GaragePhoto.where(:original_url => img, :garage_id => garage_id).first_or_create(:photo => open(img)).save
        end
      end
      GaragePhotoSweeper.send(:new).sweep(GaragePhoto.last)
      TagSweeper.send(:new).sweep(Tag.last)
    end

private

  def incremented_added_content
    garage.update_attribute(:added_content, Time.now)
  end
end

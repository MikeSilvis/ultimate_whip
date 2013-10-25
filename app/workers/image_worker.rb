require 'open-uri'

class ImageWorker
  include Sidekiq::Worker
  attr_accessor :urls, :div, :garage_id

  def perform(urls, div, garage_id)
    self.urls, self.div, self.garage_id = urls, div, garage_id
    process_and_upload_images
  end

  def urls
    @urls.split(",").map(&:strip)
  end

private

  def process_and_upload_images
    images.each do |img|
      garage.photos.where(original_url: img).first_or_create(photo: open(img)).save
    end
  end

  def images
    @images ||= ImageScrapper.new(urls, div).find_all_images
  end

  def garage
    @garage ||= Garage.where(id: self.garage_id).includes(:photos).first
  end

end

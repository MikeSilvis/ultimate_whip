require 'nokogiri'
require 'open-uri'
require 'mini_magick'

class ImageScrapper
  attr_accessor :post_url

  def initialize post_url
    self.post_url = post_url
  end

  def find_all_images
    all_pages.collect do |page|
      all_images.concat find_images_for_page(page)
    end
    all_images_urls
  end

  def find_images_for_page(page)
    page.xpath('//div[starts-with(@id, "post_message")]').search("img").select do |image|
      valid_image?(image['src']) ? image['src'] : nil
    end
  end

  def valid_image?(image_url)
    if image_url =~ /gif/
      false
    else
      begin
        image = MiniMagick::Image.open(image_url)
        (image[:width] > 600) && (image[:height] > 500) && (image[:format] != 'gif')
      rescue
        false
      end
    end
  end

  private

  def all_images
    @all_images ||= []
  end

  def all_images_urls
    all_images.map { |img| img['src'] }.uniq
  end

  def original_post
    @original_post ||= Nokogiri::HTML(open(post_url))
  end

  def open_next_page(current_page)
    url = current_page.search(".pagenav").xpath('//a[starts-with(@title, "Next Page")]')
    unless url.empty?
      page = Nokogiri::HTML(open(url.first["href"]))
      pages_to_check.push page
      all_pages_array.push page
    end
  end

  def all_pages
    find_more_pages
    return all_pages_array
  end

  def all_pages_array
    @all_pages_array ||= [original_post]
  end

  def pages_to_check
    @pages_to_check ||= [original_post]
  end

  def find_more_pages
    if pages_to_check.length > 0
      open_next_page(pages_to_check.pop)
      find_more_pages
    end
  end

end

require 'nokogiri'
require 'open-uri'
require 'mini_magick'

class ImageScrapper
  attr_accessor :post_urls, :div_with_images

  def initialize post_urls, div_with_images
    self.post_urls = post_urls
    self.div_with_images = div_with_images
  end

  def find_all_images
    all_pages.map do |page|
      find_images_for_page(page)
    end.flatten
  end

  def find_images_for_page(page)
    page.search("#{div_with_images}").search("img").map do |image|
      img = image['src'].to_s.gsub("medium", "large")
      valid_image?(img) ? img : nil
    end.compact
  end

  def valid_image?(image_url)
    if image_url.present? && (image_url =~ /gif/)
      false
    else
      begin
        image = MiniMagick::Image.open(image_url)
        (image[:width] > 600) && (image[:height] > 450) && (image[:format] != 'gif')
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

  def original_posts
    @original_posts ||= post_urls.map { |url| Nokogiri::HTML(open(url)) }
  end

  def open_next_page(current_page)
    url = current_page.search(".pagenav").xpath('//a[starts-with(@title, "Next Page")]')
    unless url.empty?
      page = Nokogiri::HTML(open("http://www.m3post.com/forums/#{url.first["href"]}"))
      pages_to_check.push page
      all_pages_array.push page
    end
  end

  def all_pages
    #find_more_pages
    return all_pages_array
  end

  def all_pages_array
    @all_pages_array ||= original_posts
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

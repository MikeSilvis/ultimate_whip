require 'nokogiri'
require 'open-uri'

class BlogScrapper
  attr_accessor :blog_url

  def initialize blog_url
    self.blog_url = blog_url
  end

  def find_all_posts
    blog.xpath('//a[starts-with(@id, "thread_title")]').collect do |link|
      link
    end
  end

  def blog
    Nokogiri::HTML(open(blog_url))
  end

end

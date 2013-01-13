require File.expand_path("../../../app/lib/blog_scrapper.rb", __FILE__)
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe BlogScrapper do
  let(:blog_url) { "http://www.m3post.com/forums/forumdisplay.php?f=64" }
  let(:scrapper) { BlogScrapper.new(blog_url) }
  context "#find_all_posts" do
    it "find all the posts on the first page" do
      VCR.use_cassette('find_all_posts') do
        BlogScrapper.new(blog_url).find_all_posts.size.should == 45
      end
    end
  end
end

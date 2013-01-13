require File.expand_path("../../../app/lib/image_scrapper.rb", __FILE__)
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe ImageScrapper do
  let(:post_url) { "http://www.m3post.com/forums/showthread.php?t=781467" }

  context "#find_images_for_page" do
    it "finds all the images that could be relative" do
      VCR.use_cassette('find_images_for_page') do
        original_post = ImageScrapper.new(post_url).send(:original_post)
        ImageScrapper.new(post_url).find_images_for_page(original_post).size.should == 15
      end
    end
  end

  context "#find_all_images" do
    it "finds all images on the first page and the rest of the pages" do
      VCR.use_cassette('find_all_images') do
        ImageScrapper.new(post_url).find_all_images.size.should == 15
      end
    end
  end

  context "#valid_image?" do
    it "returns an image larger than 600x500" do
      VCR.use_cassette('valid_image') do
        ImageScrapper.new(post_url).valid_image?('http://www.ind-distribution.com/images/AT34.jpg').should be_true
      end
    end
    it "returns false an image smaller than 600x500" do
      VCR.use_cassette('invalid_image') do
        ImageScrapper.new(post_url).valid_image?('http://www.m3post.com/forums/customavatars/avatar74907_1.gif').should_not be_true
      end
    end
  end

  context "#all_pages" do
    it "combines all of the pages together" do
      VCR.use_cassette('all_pages') do
        # Note this number could easily change with the posts on the page increasing
        ImageScrapper.new(post_url).send(:all_pages).size.should == 4
      end
    end
  end

end

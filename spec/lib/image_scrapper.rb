require File.expand_path("../../../app/lib/image_scrapper.rb", __FILE__)

describe ImageScrapper do
  let(:post_url) { "http://www.m3post.com/forums/showthread.php?t=781467" }

  context "#find_images_for_page" do
    it "finds all the images that could be relative" do
      original_post = ImageScrapper.new(post_url).send(:original_post)
      ImageScrapper.new(post_url).find_images_for_page(original_post).size.should == 15
    end
  end

  context "#find_all_images" do
    it "finds all images on the first page and the rest of the pages" do
      ImageScrapper.new(post_url).find_all_images.size.should == 15
    end
  end

  context "#valid_image?" do
    it "returns an image larger than 600x500" do
      MiniMagick::Image.any_instance.stub(:open).and_return(true)
      ImageScrapper.new(post_url).valid_image?('http://www.ind-distribution.com/images/AT34.jpg').should be_true
    end
    it "returns false an image smaller than 600x500" do
      ImageScrapper.new(post_url).valid_image?('http://www.m3post.com/forums/customavatars/avatar74907_1.gif').should_not be_true
    end
  end

  context "#all_pages" do
    it "combines all of the pages together" do
      ImageScrapper.new(post_url).send(:all_pages).size.should == 3
    end
  end

end

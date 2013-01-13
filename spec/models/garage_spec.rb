require 'spec_helper'

describe Garage do
  context "#tag_list" do
    it "after create it makes a new default tag" do
      garage = FactoryGirl.create(:garage)
      garage.tag_list.join(", ").should == "#{garage.color.name}, #{garage.model.name}, #{garage.model.make.name}"
    end
    it "updates the tag list" do
      garage = FactoryGirl.create :garage
      garage.tag_list = "bam"
      garage.tag_list.should == ["bam"]
    end
  end
end

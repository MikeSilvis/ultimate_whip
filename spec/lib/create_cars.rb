require File.expand_path("../../../app/lib/create_cars.rb", __FILE__)
describe CreateCars do
  context "Normalizes the data to be prepared for the database" do
    it "converts makes into a rails hash" do
      CreateCars.normalize_makes.first[:name].should == "Acura"
    end
    it "converts models into a rails hash that are only of type 1 and have a make" do
      CreateCars.normalize_models.size.should_not == 1208
    end
  end
end

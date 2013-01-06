task :create_cars => :environment do
  Model.create_from_yaml
end

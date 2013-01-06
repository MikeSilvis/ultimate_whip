desc "scrapes a given url and adds those photos to a specific garage"
task :scrape => :environment do
  values = ENV['PARAMS'].split(',')
  GaragePhoto.create_photos_from_blog(values[0], values[1])
end

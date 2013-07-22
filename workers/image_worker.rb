require 'typhoeus'
require './lib/image_scrapper'

images =ImageScrapper.new(params[:url], params[:div]).find_all_images
puts images

Typhoeus.put("localhost:3000/api/v1/garages/#{id}", images: images)

puts 'job complete'

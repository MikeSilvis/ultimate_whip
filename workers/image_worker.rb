require 'typhoeus'
require './lib/image_scrapper'

puts "URLs are" + params[:urls]
puts "Div is" + params[:div]
puts "id is" + params[:id]

images =ImageScrapper.new(params[:urls], params[:div]).find_all_images
puts images

Typhoeus.put("localhost:3000/api/v1/garages/#{params[:id]}", images: images, api: "mikeisawesome" )

puts 'job complete'

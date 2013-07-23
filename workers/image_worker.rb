require 'typhoeus'
require 'uri'
require './lib/image_scrapper'
#URL = 'http://localhost:3000'
URL = 'http://auxotic.com'

puts "URLs are #{params[:urls]}"
puts "Div is #{params[:div]}"
puts "id is #{params[:id]}"

images = ImageScrapper.new(params[:urls], params[:div]).find_all_images
puts images

images.each_slice(5) do |grouped_images|
  call = Typhoeus.put("#{URL}/api/v1/garages/#{params[:id]}?api=mikeisawesome", params: { images: grouped_images } )
  puts call.code
  puts call.body
end

puts 'job complete'

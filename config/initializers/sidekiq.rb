#Sidekiq.configure_server do |config|
  #config.redis = { :url => 'redis://redis.example.com:7372/12' }
#end

#Sidekiq.configure_client do |config|
  #config.redis = { :url => 'redis://redis.example.com:7372/12' }
#end

require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { :size => 2 }
end

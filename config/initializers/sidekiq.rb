require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDISTOGO_URL'], :namespace => 'tweetlinks-sidekiq' }
end

Sidekiq.configure_server do |config|
  config.redis = { :url => ENV['REDISTOGO_URL'], :namespace => 'tweetlinks-sidekiq' }
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :twitter,
    ENV['TWEETLINKS_TWITTER_CONSUMER_KEY'],
    ENV['TWEETLINKS_TWITTER_CONSUMER_SECRET']
  )
end

class TweetProcessor

  def initialize(user)
    @user = user
  end

  def process(tweet)
    if tweet.urls.present?
      url = tweet.urls.first
      twitter_user = TwitterUser.find_or_create_for_tweet(tweet)
      Tweet.create! do |t|
        t.user_id = @user.id
        t.twitter_id = tweet.id
        t.tweet_content = tweet.text
        t.tweeted_at = tweet.created_at
        t.url = url.expanded_url || url.url
        t.twitter_user = twitter_user
      end
    end
  end
end

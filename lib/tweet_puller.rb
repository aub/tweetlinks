class TweetPuller

  MAX_TWEETS = 800

  def initialize(user)
    @user = user
  end

  def each_new_tweet(&block)
    min_id_pulled = nil
    max_id_pulled = @user.last_tweet_id
    tweets_pulled = 0
    while true
      data = tweets(min_id_pulled)
      if data.present?
        data.each do |tweet|
          block.call(tweet)
          min_id_pulled = [min_id_pulled, tweet.id - 1].compact.min
          max_id_pulled = [max_id_pulled, tweet.id].compact.max
        end
        if (tweets_pulled += data.count) >= MAX_TWEETS
          break
        end
      else
        break
      end
    end
  ensure
    @user.update_attribute(:last_tweet_id, max_id_pulled)
  end

  private

  def client
    @client ||= Twitter::Client.new(
      oauth_token: @user.access_token,
      oauth_token_secret: @user.access_secret
    )
  end

  def tweets(max_id)
    options = { count: 200 }
    if @user.last_tweet_id
      options[:since_id] = @user.last_tweet_id
    end
    if max_id
      options[:max_id] = max_id
    end
    data = client.home_timeline(options)
  end
end

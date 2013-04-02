class TweetPuller

  MAX_TWEETS = 25

  def initialize(user)
    @user = user
  end

  def each_new_tweet(&block)
    retry_count = 3
    begin
      min_id_pulled = nil
      max_id_pulled = @user.last_tweet_id
      tweets_pulled = 0
      while true
        data = tweets(min_id_pulled)
        if data.present?
          data.each do |tweet|
            if tweet.urls.present?
              block.call(tweet)
              if (tweets_pulled += 1) >= MAX_TWEETS
                break
              end
            end
            min_id_pulled = [min_id_pulled, tweet.id - 1].compact.min
            max_id_pulled = [max_id_pulled, tweet.id].compact.max
          end
        else
          break
        end
      end
    rescue Twitter::Error::TooManyRequests => e
      print ' rate limited!! '
      nil # try again next time
    rescue Twitter::Error::ClientError => e
      if (retry_count -= 1) >= 0
        print ' retry! '
        retry
      else
        raise
      end
    ensure
      @user.update_attribute(:last_tweet_id, max_id_pulled)
    end
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

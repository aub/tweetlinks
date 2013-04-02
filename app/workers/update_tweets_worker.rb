class UpdateTweetsWorker

  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(user_id)
    user = User.find(user_id)
    processor = TweetProcessor.new(user)
    TweetPuller.new(user).each_new_tweet do |tweet|
      processor.process(tweet)
    end
  end
end

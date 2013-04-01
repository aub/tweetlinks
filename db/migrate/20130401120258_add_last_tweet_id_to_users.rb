class AddLastTweetIdToUsers < ActiveRecord::Migration
  def change
    add_column 'users', 'last_tweet_id', :integer
  end
end

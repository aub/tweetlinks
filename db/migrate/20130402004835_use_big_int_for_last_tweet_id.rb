class UseBigIntForLastTweetId < ActiveRecord::Migration
  def up
    change_column 'users', 'last_tweet_id', :integer, limit: 8
  end

  def down
    change_column 'users', 'last_tweet_id', :integer, limit: 4
  end
end

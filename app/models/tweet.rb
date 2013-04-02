class Tweet < ActiveRecord::Base

  belongs_to :user
  belongs_to :twitter_user

  validates :user_id, presence: true
  validates :twitter_user_id, presence: true
  validates :twitter_id, presence: true, uniqueness: { scope: :user_id }
  validates :tweet_content, presence: true
  validates :tweeted_at, presence: true
  validates :url, presence: true
end

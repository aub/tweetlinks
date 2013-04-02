class TwitterUser < ActiveRecord::Base

  include DataViews

  has_many :tweets

  validates :screen_name, presence: true, uniqueness: true
  validates :name, presence: true
  validates :profile_image_url, presence: true
  validates :twitter_id, presence: true, uniqueness: true

  data_view :full do
    property :name, :screen_name
  end

  def self.find_or_create_for_tweet(tweet)
    user = find_by_twitter_id(tweet.user.id)
    user ||= create! do |user|
      user.screen_name = tweet.user.screen_name
      user.name = tweet.user.name
      user.profile_image_url = tweet.user.profile_image_url
      user.twitter_id = tweet.user.id
    end
  end
end

class Tweet < ActiveRecord::Base

  belongs_to :user
  belongs_to :twitter_user

  validates :user_id, presence: true
  validates :twitter_user_id, presence: true
  validates :twitter_id, presence: true, uniqueness: { scope: :user_id }
  validates :tweet_content, presence: true
  validates :tweeted_at, presence: true
  validates :url, presence: true

  after_create :queue_up_image_capture

  scope :with_cloudinary_id, where('cloudinary_id IS NOT NULL')

  def to_builder
    Jbuilder.new do |tweet|
      tweet.twitter_user twitter_user.to_builder
      tweet.twitter_id twitter_id
      tweet.tweeted_at tweeted_at
      tweet.url url
      tweet.tweet_content tweet_content
    end
  end

  private

  def queue_up_image_capture
    CaptureImageWorker.perform_async(self.id)
  end
end

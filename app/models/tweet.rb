class Tweet < ActiveRecord::Base

  include DataViews

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

  scope :recent_first, order('tweeted_at DESC')

  scope :most_recent, lambda { |span|
    where(['tweeted_at > ?', Time.now - span])
  }

  data_view :full do
    property :cloudinary_id
    property :twitter_id
    property :tweeted_at
    property :url
    property :tweet_content
    property(:twitter_user) { twitter_user.with_data_view(:full) }
  end

  private

  def queue_up_image_capture
    CaptureImageWorker.perform_async(self.id)
  end
end

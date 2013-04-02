class User < ActiveRecord::Base

  validates :twitter_uid, uniqueness: true
  validates :screen_name, presence: true
  validates :access_token, presence: true
  validates :access_secret, presence: true

  has_many :tweets

  def to_builder
    Jbuilder.new do |user|
      user.(self, :name, :screen_name)
    end
  end

  def self.find_or_create_from_auth_hash(hash)
    user = self.where(twitter_uid: hash.uid).first
    user ||= create! do |u|
      u.twitter_uid = hash.uid
      u.name = hash.info.name
      u.screen_name = hash.info.nickname
      u.access_secret = hash.credentials.secret
      u.access_token = hash.credentials.token
    end
  end
end

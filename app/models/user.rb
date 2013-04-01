class User < ActiveRecord::Base

  validates :twitter_uid, uniqueness: true

  def to_builder
    Jbuilder.new do |user|
      user.(self, :name)
    end
  end

  def self.find_or_create_from_auth_hash(hash)
    user = self.where(twitter_uid: hash.uid).first
    user ||= create do |u|
      u.twitter_uid = hash.uid
      u.name = hash.info.name
      u.access_secret = hash.credentials.secret
      u.access_token = hash.credentials.token
    end
  end
end

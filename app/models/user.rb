class User < ActiveRecord::Base

  validates :twitter_uid, uniqueness: true

  def self.find_or_create_from_auth_hash(hash)
    user = self.where(twitter_uid: hash.uid).first
    user ||= create do |u|
      u.twitter_uid = hash.uid
      u.name = hash.info.name
    end
  end
end

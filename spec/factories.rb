require 'factory_girl'

FactoryGirl.define do

  factory :tweet do
    user
    twitter_user
    sequence(:twitter_id) { |n| n }
    tweet_content { Faker::Lorem.words(10).join(' ') }
    tweeted_at { Time.now }
    url { Faker::Internet.url }
  end

  factory :twitter_user do
    screen_name { Faker::Name.name.underscore }
    name { Faker::Name.name }
    profile_image_url "https://a1.twimg.com/profile_images/553508996/43082001_N00_normal.jpg"
    sequence(:twitter_id) { |n| 1000000000 + n }
  end

  factory :user do
    sequence(:twitter_uid) { |n| "#{n}23456" }
    name { Faker::Name.name }
    screen_name { Faker::Name.name.underscore }
    sequence(:access_token) { |n| n.to_s }
    sequence(:access_secret) { |n| n.to_s }
  end
end

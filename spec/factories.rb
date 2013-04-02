require 'factory_girl'

FactoryGirl.define do

  factory :twitter_user do
    screen_name { Faker::Name.name.underscore }
    name { Faker::Name.name }
    profile_image_url "https://a1.twimg.com/profile_images/553508996/43082001_N00_normal.jpg"
    sequence(:twitter_id) { |n| 1000000000 + n }
  end

  factory :user do
    sequence(:twitter_uid) { |n| "#{n}23456" }
    name { Faker::Name.name }
  end
end

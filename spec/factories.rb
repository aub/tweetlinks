require 'factory_girl'

FactoryGirl.define do

  factory :user do
    sequence(:twitter_uid) { |n| "#{n}23456" }
    name { Faker::Name.name }
  end
end

require 'spec_helper'

describe TwitterUser do

  let(:tweet) { create_tweet }

  context 'creating a new twitter user' do

    let(:user) { TwitterUser.find_or_create_for_tweet(tweet) }

    it 'should create a new instance from a tweet' do
      user.should be_an_instance_of(TwitterUser)
    end

    it 'should fill in the data from the tweet' do
      user.screen_name.should == tweet[:user][:screen_name]
      user.name.should == tweet[:user][:name]
      user.profile_image_url.should == tweet[:user][:profile_image_url]
      user.twitter_id.should == tweet[:user][:id]
    end
  end

  it 'should find an existing instance from a tweet' do
    tu = FactoryGirl.create(:twitter_user, twitter_id: tweet.user.id)
    user = TwitterUser.find_or_create_for_tweet(tweet)
    user.should == tu
  end

  describe 'data views' do

    let(:twitter_user) { FactoryGirl.create(:twitter_user) }

    it 'should produce a json document' do
      doc = twitter_user.with_data_view(:full)
      doc.should == {
        name: twitter_user.name,
        screen_name: twitter_user.screen_name
      }
    end
  end

  private

  def create_tweet
    Twitter::Tweet.new(
      id: rand(1000000000),
      user: {
        name: Faker::Name.name,
        profile_image_url_https: "https://a1.twimg.com/profile_images/553508996/43082001_N00_normal.jpg",
        id: rand(10000000000),
        screen_name: Faker::Name.name.underscore
      },
    )
  end

end

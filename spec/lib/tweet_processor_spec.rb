require 'spec_helper'

describe TweetProcessor do
  let(:user) { FactoryGirl.create(:user) }
  let(:processor) { TweetProcessor.new(user) }
  let(:tweet) { user.reload.tweets.first }
  let(:fake_tweet) { create_tweet([]) }
  let(:url) { 'http://bozo.com' }

  it 'should not create a tweet with no entities' do
    processor.process(fake_tweet)
    user.tweets.count.should == 0
  end

  context 'with a single url' do
    let(:fake_tweet) { create_tweet([url]) }

    before do
      processor.process(fake_tweet)
    end

    it 'should create a tweet' do
      tweet.should be
    end

    it 'should have the correct data in the tweet' do
      tweet.user_id.should == user.id
      tweet.twitter_id.should == fake_tweet.id
      tweet.tweet_content.should == fake_tweet.text
      tweet.tweeted_at.should == fake_tweet.created_at
      tweet.url.should == 'http://bozo.com'
    end

    it 'should create a twitter user for the tweet' do
      tweet.twitter_user.should be_an_instance_of(TwitterUser)
    end
  end

  private

  def create_tweet(urls=[])
    mapped_urls = urls.map do |url|
      {
        expanded_url: url,
        url: 'http://t.co/ffdsfsdf',
        indices: [ 75, 123 ],
        display_url: url.sub('^http://', '')
      }
    end
    Twitter::Tweet.new(
      id: rand(1000000000),
      entities: {
        urls: mapped_urls
      },
      text: 'test tweet',
      created_at: 'Tue Aug 28 21:16:23 +0000 2012',
      user: {
        name: Faker::Name.name,
        profile_image_url_https: "https://a1.twimg.com/profile_images/553508996/43082001_N00_normal.jpg",
        id: rand(10000000000),
        screen_name: Faker::Name.name.underscore
      },
    )
  end
end

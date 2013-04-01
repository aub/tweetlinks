require 'spec_helper'

describe TweetPuller do

  let(:user) do
    FactoryGirl.create(
      :user,
      access_token: '123',
      access_secret: 'abc'
    )
  end

  let(:puller) { TweetPuller.new(user) }

  before do
    @current_id = 1000
    rr_pairs.each do |params, response|
      params.merge!(count: 200)
      stub_request(
        :get,
        "https://api.twitter.com/1.1/statuses/home_timeline.json?#{params.to_param}"
      ).to_return(body: response)
    end

    @pulled_ids = [].tap do |ids|
      puller.each_new_tweet do |tweet|
        ids << tweet.id
      end
    end
  end

  context 'with a few tweets' do
    let(:rr_pairs) do
      [
        [{}, fake_tweets(5, 1000)],
        [{ max_id: 999 }, fake_tweets(0, 2000) ]
      ]
    end

    it 'should pull tweets' do
      @pulled_ids.should =~ (1000..1004).to_a
    end
  end

  context 'with pagination' do
    let(:rr_pairs) do
      [
        [{}, fake_tweets(5, 1000)],
        [{ max_id: 999 }, fake_tweets(5, 900)],
        [{ max_id: 899 }, fake_tweets(0, 2000) ]
      ]
    end

    it 'should get all of the ids' do
      @pulled_ids.should =~ (1000..1004).to_a.concat((900..904).to_a)
    end

    it 'should set the since_id in the user' do
      user.reload.last_tweet_id.should == 1004
    end
  end

  private

  def fake_tweets(count, start_id)
    user_id = 0
    current_id = start_id
    data = (1..count).map do
      tweet = {
        "created_at" => "Tue Aug 28 21:16:23 +0000 2012",
        "id_str" => current_id.to_s,
        "entities" => {
          "urls" => [
          ]
        },
        "text" => "just another test",
        "id" => current_id,
        "retweeted" => false,
        "user" => {
          "screen_name" => "user-#{user_id += 1}",
          "name" => Faker::Name.name,
          "profile_image_url" => "http://a0.twimg.com/profile_images/1/ack.jpg",
          "id_str" => user_id.to_s,
          "id" => user_id
        }
      }
      current_id += 1
      tweet
    end
    MultiJson.encode(data)
  end
end

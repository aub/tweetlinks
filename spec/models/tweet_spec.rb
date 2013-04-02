require 'spec_helper'

describe Tweet do

  let(:tweet) { FactoryGirl.create(:tweet) }

  describe '#to_builder' do

    it 'should produce a json document' do
      doc = tweet.to_builder.target!
      MultiJson.decode(doc).should == {
        'tweet_content' => tweet.tweet_content,
        'tweeted_at' => MultiJson.decode(tweet.tweeted_at.to_json),
        'twitter_id' => tweet.twitter_id,
        'twitter_user' => MultiJson.decode(tweet.twitter_user.to_builder.target!),
        'url' => tweet.url
      }
    end
  end
end

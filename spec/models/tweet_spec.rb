require 'spec_helper'

describe Tweet do

  let(:tweet) { FactoryGirl.create(:tweet) }

  describe 'data views' do

    it 'should produce a json document' do
      doc = tweet.with_data_view(:full)
      doc.should == {
        cloudinary_id: tweet.cloudinary_id,
        tweet_content: tweet.tweet_content,
        tweeted_at: tweet.tweeted_at,
        twitter_id: tweet.twitter_id,
        twitter_user: tweet.twitter_user.with_data_view(:full),
        url: tweet.url
      }
    end
  end
end

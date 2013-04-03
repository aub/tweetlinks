require 'spec_helper'

describe Api::V1::TweetsController do

  let(:user) { FactoryGirl.create(:user) }

  describe '#index' do
    it 'should require login' do
      get :index
      response.status.should == 401
    end

    context 'with a logged-in user' do

      before do
        session[:user_id] = user.id
      end

      it 'should be successful' do
        get :index
        response.should be_success
      end

      it 'should return an empty array' do
        get :index
        response.body.should == { tweets: [] }.to_json
      end

      context 'with some tweets' do
      
        let!(:tweets) do
          [
            FactoryGirl.create(:tweet, user: user, tweeted_at: 5.hours.ago),
            FactoryGirl.create(:tweet, user: user, tweeted_at: 1.minute.ago),
            FactoryGirl.create(:tweet, user: user, tweeted_at: 10.minutes.ago)
          ]
        end

        it 'should return the tweets as json' do
          get :index
          data = tweets.map { |t| t.with_data_view(:full) }
          MultiJson.decode(response.body, :symbolize_keys => true)[:tweets].map { |i| i[:twitter_id] }.should =~ tweets.map(&:twitter_id)
        end

        it 'should order the tweets by tweeted_at' do
          get :index
          data = tweets.map { |t| t.with_data_view(:full) }
          MultiJson.decode(response.body, :symbolize_keys => true)[:tweets].map { |i| i[:twitter_id] }.should == tweets.sort_by(&:tweeted_at).reverse.map(&:twitter_id)
        end

        it 'should paginate the tweets' do
          get :index, per_page: 1, page: 1
          data = tweets.map { |t| t.with_data_view(:full) }
          MultiJson.decode(response.body, :symbolize_keys => true)[:tweets].map { |i| i[:twitter_id] }.should =~ [tweets[1].twitter_id]

        end
      end

      context 'with some tweets sans cloudinary id' do
        let!(:tweets) do
          [
            FactoryGirl.create(:tweet, user: user, cloudinary_id: nil),
            FactoryGirl.create(:tweet, user: user, cloudinary_id: nil)
          ]
        end

        it 'should return the tweets as json' do
          get :index
          response.body.should == { tweets: [] }.to_json
        end
      end
    end
  end
end

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
            FactoryGirl.create(:tweet, user: user),
            FactoryGirl.create(:tweet, user: user)
          ]
        end

        it 'should return the tweets as json' do
          get :index
          response.body.should == { tweets: tweets }.to_json
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

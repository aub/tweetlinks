require 'spec_helper'

describe User do
  describe '#find_or_create_from_auth_hash' do
    let(:auth_hash) do
      Hashie::Mash.new({
        uid: '123',
        info: {
          name: 'Aubrey Holland'
        },
        credentials: {
          token: 'blahblahblah',
          secret: 'ackackack'
        }
      })
    end

    context 'when creating a new user' do
      let(:user) do
        user = User.find_or_create_from_auth_hash(auth_hash)
      end

      it 'should create one' do
        user.should be_an_instance_of(User)
        user.twitter_uid.should == '123'
      end

      it 'should set the name' do
        user.name.should == 'Aubrey Holland' 
      end

      it 'should set the access_token' do
        user.access_token.should == 'blahblahblah'
      end

      it 'should set the access secret' do
        user.access_secret.should == 'ackackack'
      end
    end

    context 'with an existing user' do
      let!(:created_user) do
        FactoryGirl.create(
          :user,
          :twitter_uid => '123'
        )
      end

      let(:user) { User.find_or_create_from_auth_hash(auth_hash) }

      it 'should find one' do
        user.should be_an_instance_of(User)  
      end

      it 'should be the created user' do
        user.id.should == created_user.id
      end
    end
  end

  describe 'to_builder' do
    let(:user) { FactoryGirl.create(:user) }

    it 'should have a json representation' do
      doc = user.to_builder.target!
      MultiJson.decode(doc).should == { 'name' => user.name }
    end
  end
end
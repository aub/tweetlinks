require 'spec_helper'

describe User do
  describe '#find_or_create_from_auth_hash' do
    let(:auth_hash) do
      Hashie::Mash.new({
        uid: '123',
        info: {
          name: 'Aubrey Holland'
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
end

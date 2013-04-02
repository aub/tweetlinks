require 'spec_helper'

describe SessionsController do
  let(:auth_hash) do
    Hashie::Mash.new({
      uid: '123',
      info: {
        name: 'Aubrey Holland',
        nickname: 'riotpolice'
      },
      credentials: {
        token: 'abc',
        secret: '123'
      }
    })
  end

  before do
    request.env['omniauth.auth'] = auth_hash
  end

  describe '#create' do
    before do
      get :create
    end

    it 'should redirect home' do
      response.should redirect_to root_path
    end

    it 'should set the current_user' do
      u = controller.current_user
      u.twitter_uid.should == '123'
      u.name.should == 'Aubrey Holland'
    end
  end
end

require 'spec_helper'

describe ApplicationController do
  let(:user) { FactoryGirl.create(:user) }

  it 'should store the current user in the session' do
    controller.current_user = user
    session[:user_id].should == user.id
  end

  it 'should recover the user from the session' do
    controller.current_user = user
  end

  it 'should recover the user from the session' do
    session[:user_id] = user.id
    controller.current_user.should == user
  end

  it 'should be ok with nothing in the session' do
    controller.current_user.should be_nil
  end
end

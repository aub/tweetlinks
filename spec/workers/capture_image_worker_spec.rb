require 'spec_helper'

describe CaptureImageWorker do
  let(:tweet) { FactoryGirl.create(:tweet, url: 'http://www.google.com' ) }
  let(:worker) { CaptureImageWorker.new }
  let(:filename) do
    File.join(Rails.root, 'tmp', tweet.id.to_s) + '.png'
  end

  before do
    # worker.should_receive(:`).and_return(true)
    # File.should_receive(:exists?).with(filename).and_return(true)
    # File.should_receive(:open).with(filename, 'r').and_return(true)
    # stub_request(:post, "https://api.cloudinary.com/v1_1/tweetlinks/image/upload")
    # worker.perform(tweet.id)
  end

  it 'should be awesome'
end

class CaptureImageWorker

  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    filename = File.join(
      Rails.root,
      'tmp',
      UUIDTools::UUID.random_create.to_s
    )
    filename += '.png'

    script = File.join(Rails.root, 'script', 'capture_image.js')
    output = `phantomjs #{script} #{tweet.url} #{filename}`

    if File.exists?(filename)
      file = File.open(filename, 'r')
      data = Cloudinary::Uploader.upload(file, format: 'png')
      # DATA LOOKS LIKE THIS:
      # {"public_id"=>"syv4gtely1i6nzognznl", "version"=>1364868495, "signature"=>"f43c9362debf3230e27cd86795c13275dc4a2033", "width"=>977, "height"=>3108, "format"=>"png", "resource_type"=>"image", "created_at"=>"2013-04-02T02:08:15Z", "bytes"=>1160218, "type"=>"upload", "url"=>"http://res.cloudinary.com/tweetlinks/image/upload/v1364868495/syv4gtely1i6nzognznl.png", "secure_url"=>"https://cloudinary-a.akamaihd.net/tweetlinks/image/upload/v1364868495/syv4gtely1i6nzognznl.png"}
      File.delete(filename)
    end
  end
end

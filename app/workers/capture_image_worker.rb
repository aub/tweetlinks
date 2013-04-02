class CaptureImageWorker

  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    filename = File.join(
      Rails.root,
      'tmp',
      tweet.id.to_s
    )
    filename += '.png'

    script = File.join(Rails.root, 'script', 'capture_image.js')
    output = `phantomjs #{script} #{tweet.url} #{filename}`

    if File.exists?(filename)
      file = File.open(filename, 'r')
      data = Cloudinary::Uploader.upload(file, format: 'png')
      tweet.update_attribute(:cloudinary_id, data['public_id'])
      File.delete(filename)
    end
  end
end
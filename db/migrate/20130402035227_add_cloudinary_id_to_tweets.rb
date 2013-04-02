class AddCloudinaryIdToTweets < ActiveRecord::Migration
  def change
    add_column 'tweets', 'cloudinary_id', :string
  end
end

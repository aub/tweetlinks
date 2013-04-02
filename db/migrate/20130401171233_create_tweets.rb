class CreateTweets < ActiveRecord::Migration
  def up
    create_table 'tweets', force: true do |t|
      t.references :user
      t.references :twitter_user
      t.integer :twitter_id, limit: 8
      t.text :tweet_content
      t.datetime :tweeted_at
      t.text :url
      t.timestamps
    end

    add_index 'tweets', [:user_id, :tweeted_at]
    add_index 'tweets', :twitter_user_id

    create_table 'twitter_users', force: true do |t|
      t.string :screen_name
      t.string :name
      t.text :profile_image_url
      t.integer :twitter_id, limit: 8
    end

    add_index 'twitter_users', :screen_name, :unique => true
  end

  def down
    drop_table 'twitter_users'
    drop_table 'tweets'
  end
end

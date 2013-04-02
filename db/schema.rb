# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130401171233) do

  create_table "tweets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "twitter_user_id"
    t.integer  "twitter_id",      :limit => 8
    t.text     "tweet_content"
    t.datetime "tweeted_at"
    t.text     "url"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "tweets", ["twitter_user_id"], :name => "index_tweets_on_twitter_user_id"
  add_index "tweets", ["user_id", "tweeted_at"], :name => "index_tweets_on_user_id_and_tweeted_at"

  create_table "twitter_users", :force => true do |t|
    t.string  "screen_name"
    t.string  "name"
    t.text    "profile_image_url"
    t.integer "twitter_id",        :limit => 8
  end

  add_index "twitter_users", ["screen_name"], :name => "index_twitter_users_on_screen_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "auth_token"
    t.string   "auth_secret"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "twitter_uid"
    t.string   "name"
    t.string   "access_token"
    t.string   "access_secret"
    t.integer  "last_tweet_id"
  end

end

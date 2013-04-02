namespace :tweets do
  desc 'Pull the latest tweets for each user'
  task :pull_latest => :environment do
    User.all.each do |user|
      print "Pulling tweets for #{user.screen_name} "
      processor = TweetProcessor.new(user)
      TweetPuller.new(user).each_new_tweet do |tweet|
        print '.'
        processor.process(tweet)
      end
      puts ''
    end
  end
end

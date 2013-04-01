namespace :tweets do
  desc 'Pull the latest tweets for each user'
  task :pull_latest => :environment do
    User.all.each do |user|
      TweetPuller.new(user).pull
    end
  end
end

namespace :tweets do
  desc 'Pull the latest tweets for each user'
  task :pull_latest => :environment do
    User.select(:id).all.each do |user|
      UpdateTweetsWorker.perform_async(user.id)
    end
  end
end

= tweetlinks

Display the links from your twitter feed in a sexy way

== Notes



== Setup

  brew install phantomjs
  createdb tweetlinks_development
  createdb tweetlinks_test
  rake db:schema:load db:migrate
  export TWEETLINKS_TWITTER_CONSUMER_KEY=a key
  export TWEETLINKS_TWITTER_CONSUMER_SECRET=a secret
  export TWEETLINKS_SESSION_SECRET=blahblahblah
  rspec spec
  rails s puma -p 3006
  open http://localhost:3006/specs

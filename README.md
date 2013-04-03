tweetlinks
==========

View this live at [tweetlinks.herokuapp.com](http://tweetlinks.herokuapp.com/).

Display the links from your twitter feed in a sexy way. This project does the following:

+ Creates an account for you with Twitter's OAuth service
+ Pulls down your tweets, selecting only those that contain links
+ For each link, runs PhantomJS to take a screenshot of the link
+ Displays all of your links, with the accompanying tweet in a cute masonry view with the ability to pop up a modal with a bigger image on click.

Tech Used
---------

+ Rails. Obviously.
+ Sidekiq
+ Cloudinary (for image uploads, transformations)
+ PhantomJS (for image capture)
+ Backbone.js

Notes/Limitations/Regrets/Apologies
-----------------------------------

+ Check out the TODO.txt file for implementation steps.
+ Once you auth, you'll get a blank screen. Wait a minute or so and reload the browser to get some results. I have a TODO to add a spinner and polling.
+ I've tested this on Google Chrome. For all I know it only works in Chrome. I'm fine with that.
+ I really tried to embrace TDD on the client with Jasmine for this, but I'm afraid I couldn't get it working very well. There is a remnant of the tests left to shame me into making it work properly at some point. The server-side tests I feel good about.
+ I haven't really attempted to make this scalable. Like, not at all. Though I think it's interesting enough to play around with that in the future. For example, right now it will keep all of your tweets into eternity, and it will also pull them all down via the API. Demoware.

Setup for running locally
-------------------------

I think this is pretty complete, but please feel free to reach out to
me with any problems you run into.

```
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
```

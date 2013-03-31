describe('tweetLinksRouter', function() {
  beforeEach(function() {
    this.router = new TweetLinks.Routers.TweetLinksRouter();
  });
  
  it('renders the home route', function() {
    this.router.home();

  });
});

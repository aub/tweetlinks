TweetLinks.Collections.TweetCollection = Backbone.Collection.extend({
  model: TweetLinks.Models.Tweet,

  url: function() {
    return '/api/v1/tweets';
  },

  parse: function(response) {
    return response.tweets;
  }
});

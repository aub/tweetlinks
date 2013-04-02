TweetLinks.Models.Tweet = Backbone.Model.extend({

  paramRoot: 'tweet',

  urlRoot: function() {
    return '/api/v1/tweets';
  },

  parse: function(resp, xhr) {
    if (typeof(resp.tweet) === 'object') {
      return resp.tweet;
    } else {
      return resp;
    }
  }
});

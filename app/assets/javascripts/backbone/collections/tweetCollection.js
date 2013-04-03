TweetLinks.Collections.TweetCollection = Backbone.Paginator.requestPager.extend({

  model: TweetLinks.Models.Tweet,

  paginator_core: {
    type: 'GET',
    dataType: 'json',
    url: '/api/v1/tweets'
  },

  paginator_ui: {
    firstPage: 1,
    currentPage: 1,
    perPage: 20,
    totalPages: 0,
    count: 0
  },

  server_api: {
    'per_page': function() { return this.perPage; },
    'page': function() { return this.currentPage; }
  },

  parse: function(response) {
    return response.tweets;
  }
});

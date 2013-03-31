TweetLinks.Routers.TweetLinksRouter = Backbone.Router.extend({

  routes: {
    '': 'home'
  },

  home: function() {
    console.log("BANGIN!");
  }

});

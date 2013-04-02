TweetLinks.Routers.TweetLinksRouter = Backbone.Router.extend({

  routes: {
    '': 'home'
  },

  updateDom: function(elem) {
    $('#content-hook').html(elem);
  },

  home: function() {
    var router = this;
    if (TweetLinks.currentUser) {
      new TweetLinks.Collections.TweetCollection().fetch({
        success: function(collection) {
          options = { collection: collection };
          router.updateDom(
            new TweetLinks.Views.TweetsView(options).render().$el
          );
        },
        error: function(a, b) {
          console.log("MEGAFAIL!");
        }
      });
    } else {
      this.updateDom(new TweetLinks.Views.HomeView().render().$el);
    }
  }
});

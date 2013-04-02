TweetLinks.Routers.TweetLinksRouter = Backbone.Router.extend({

  routes: {
    '': 'home'
  },

  updateDom: function(elem) {
    $('#content-hook').html(elem);
  },

  home: function() {
    if (TweetLinks.currentUser) {
      new TweetLinks.Collections.TweetCollection().fetch({
        success: function(a, b) {
          console.log("YAY!");
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

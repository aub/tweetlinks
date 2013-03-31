TweetLinks.Routers.TweetLinksRouter = Backbone.Router.extend({

  routes: {
    '': 'home'
  },

  updateDom: function(elem) {
    $('#content-hook').html(elem);
  },

  home: function() {
    this.updateDom(new TweetLinks.Views.HomeView().render().$el);
  }

});

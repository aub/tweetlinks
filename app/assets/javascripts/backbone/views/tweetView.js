TweetLinks.Views.TweetView = Backbone.View.extend({

  render: function() {
    var $elem = $(JST['backbone/templates/tweet']({ tweet: this.model }));
    this.setElement($elem);
    return this;
  }
});

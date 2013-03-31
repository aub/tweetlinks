TweetLinks.Views.HomeView = Backbone.View.extend({

  render: function() {
    $elem = JST['backbone/templates/home']();
    this.setElement($elem);
    return this;
  }
});

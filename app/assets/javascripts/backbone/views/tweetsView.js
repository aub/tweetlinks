TweetLinks.Views.TweetsView = Backbone.View.extend({

  initialize: function(options) {
    this.collection = options.collection;
  },

  render: function() {
    var $elem = $(JST['backbone/templates/tweets']());

    var $container = $elem.find('#tweet-container');
    this.collection.each(function(tweet) {
      var view = new TweetLinks.Views.TweetView({ model: tweet });
      $container.append(view.render().$el);
    });

    $container.imagesLoaded(function(){
      $container.masonry({
        itemSelector : '.item',
        columnWidth : 30 
      });
    });

    this.setElement($elem);
    return this;
  }
});

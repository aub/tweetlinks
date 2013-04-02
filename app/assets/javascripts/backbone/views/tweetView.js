TweetLinks.Views.TweetView = Backbone.View.extend({

  events: {
    'mouseover img': 'showOverlay',
    'mouseout .overlay': 'hideOverlay'
  },

  render: function() {
    var $elem = $(JST['backbone/templates/tweet']({ tweet: this.model }));

    $elem.find('.overlay').hide();

    this.setElement($elem);
    return this;
  },

  showOverlay: function(event) {
    console.log("SHOW");
    this.$el.find('.overlay').fadeIn();
  },

  hideOverlay: function(event) {
    console.log("HIDE");
    this.$el.find('.overlay').fadeOut();
  }
});

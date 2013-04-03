TweetLinks.Views.TweetView = Backbone.View.extend({

  events: {
    'mouseenter .wrapper': 'showOverlay',
    'mouseleave .wrapper': 'hideOverlay',
    'click .overlay': 'showModal'
  },

  render: function() {
    var $elem = $(JST['backbone/templates/tweet']({ tweet: this.model }));

    $elem.find('.overlay').hide();

    this.setElement($elem);
    return this;
  },

  showOverlay: function(event) {
    this.$el.find('.overlay').fadeIn();
  },

  hideOverlay: function(event) {
    this.$el.find('.overlay').fadeOut();
  },

  showModal: function(event) {
    event.preventDefault();
    $modal = $(JST['backbone/templates/tweetModal']({
      tweet: this.model
    }));
    $modal.modal({});
  }
});

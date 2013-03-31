#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.TweetLinks = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {}
};

$(function() {
  window.router = new TweetLinks.Routers.TweetLinksRouter();
  Backbone.history.start({ pushState: true });
});



require 'spork'

ENV['RAILS_ENV'] ||= 'test'

Spork.prefork do
  require File.dirname(__FILE__) + '/../config/environment'

  require 'rspec/autorun'
  require 'rspec/rails'

  require 'webmock/rspec'
  WebMock.disable_net_connect!(:allow_localhost => true)
  # WebMock.allow_net_connect!

  RSpec.configure do |config|
    config.render_views
    config.use_transactional_fixtures = true

    config.before :each do
    end

    config.after :each do
    end
  end
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb"

  load File.dirname(__FILE__) + '/factories.rb'
end

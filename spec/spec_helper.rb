ENV["RAILS_ENV"] ||= 'test'

require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'spec/autorun'
require 'spec/rails'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
require File.expand_path(File.dirname(__FILE__) + "/blueprints")

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }
  config.mock_with :rr
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end

def setup_api
  DataCatalog.api_key = 'flurfeneugen'
  DataCatalog.base_uri = 'somehost.com'
end

def valid_user_attributes
  {
      :display_name => 'John D.',
      :email        => 'joe@test.com',
      :password     => 's3krit',
      :password_confirmation => 's3krit'
  }
end
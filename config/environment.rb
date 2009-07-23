# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  
  config.gem 'authlogic', :version => '>= 2.1.1'
  config.gem 'nokogiri', :version => '>= 1.3.2'
  config.gem 'faker', :version => '>= 0.3.1'

  
  # Testing libraries shouldn't be loaded in the running Rails app, use :lib => false
  config.gem "rspec", :lib => false, :version => ">= 1.2.0" 
  config.gem "rspec-rails", :lib => false, :version => ">= 1.2.0"
  config.gem 'thoughtbot-shoulda', :lib => false, :version => ">= 2.10.0", :source => 'http://gems.github.com'
  config.gem 'rr', :lib => false, :version => '>= 0.10.0'
  config.gem 'notahat-machinist', :lib => false, :version => ">= 1.0.3", :source => 'http://gems.github.com'
  config.gem 'webrat', :lib => false, :version => '>= 0.4.4'
  config.gem 'cucumber', :lib => false, :version => '>= 0.3.11'
  config.gem 'ZenTest', :lib => false, :version => '>= 4.0.13'
  

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  config.frameworks -= [ :active_resource ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

end
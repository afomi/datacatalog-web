# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  
  config.gem 'authlogic', :version => '>= 2.1.1'
  config.gem "authlogic-oid", :lib => "authlogic_openid", :version => '>= 1.0.4'
  config.gem "ruby-openid", :lib => "openid", :version => '>= 2.1.7'
  config.gem 'nokogiri', :version => '>= 1.3.2'
  config.gem 'faker', :version => '>= 0.3.1'
  config.gem 'rdiscount', :version => '>= 1.3.5'
  config.gem 'feedzirra', :version => '>= 0.0.20'
  config.gem 'delayed_job', :version => '>= 1.8.4'
  config.gem 'httparty', :verstion => '>= 0.5.2'
  config.gem 'datacatalog', :version => '>= 0.4.13'
  config.gem 'kronos', :version => '>= 0.1.6'
  config.gem 'unindentable', :version => '>= 0.0.1'
  config.gem "rspec", :lib => false, :version => ">= 1.2.0" 
  config.gem "rspec-rails", :lib => false, :version => ">= 1.2.0"
  config.gem 'thoughtbot-shoulda', :lib => 'shoulda', :version => ">= 2.10.0", :source => 'http://gems.github.com'
  config.gem 'rr', :version => '>= 0.10.0'
  config.gem 'notahat-machinist', :lib => 'machinist', :version => ">= 1.0.3", :source => 'http://gems.github.com'
  config.gem 'webrat', :version => '>= 0.4.5'
  config.gem 'cucumber', :version => '>= 0.3.94', :source => 'http://gems.github.com'
  config.gem 'bmabey-database_cleaner', :lib => 'database_cleaner', :version => '>= 0.2.2', :source => 'http://gems.github.com'

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

  config.action_controller.session = {
    :session_key => 'natdatcat',
    :secret      => 'f3f57b71ef9345ffccd0c4e841d8e74bb2e7d2ef692a506aa6c2a3c29d584a55dd18426ffc04610be49956a51af'
  }

  config.after_initialize do
    CACHE = Cache.new
  end
  
  config.middleware.use "Rack::Honeypot"
  
end

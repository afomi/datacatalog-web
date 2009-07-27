Webrat.configure do |config|
  config.mode = :selenium
  config.application_environment = :selenium
end

ENV["RAILS_ENV"] ||= "selenium"

World(Webrat::Selenium::Matchers)

require 'database_cleaner'
require 'database_cleaner/cucumber'
DatabaseCleaner.strategy = :truncation

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end
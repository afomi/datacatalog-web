require File.dirname(__FILE__) + '/../lib/datacatalog'
require 'yaml'

Spec::Runner.configure do |config|
  config.mock_with :rr
end

alias :executing :lambda

def setup_api
  config = YAML.load_file(File.dirname(__FILE__) + '/../sandbox_api.yml')
  DataCatalog.api_key = config['api_key']
  DataCatalog.base_uri = config['base_uri']
end

def clean_slate
  DataCatalog::User.all.each do |u|
    DataCatalog::User.destroy(u.id) unless u.name == "Primary Admin"
  end
  DataCatalog::Source.all.each do |s|
    DataCatalog::Source.destroy(s.id)
  end
end

if RUBY_VERSION >= "1.8.7"
  # Converts a valid ID into a almost-but-not-quite valid one.
  # Here is an example of what it does:
  # From ... 4ac2520b25b7e7056600034e
  # To   ... a42c25b0527b7e50660030e4
  def mangle(string)
    array = string.chars.to_a
    sliced = []
    array.each_slice(2) { |s| sliced << s.reverse }
    result = sliced.flatten.join
    raise "mangle failed" if result == string
    result
  end
else
  # Converts a valid ID into a almost-but-not-quite valid one.
  # Here is an example of what it does:
  # From ... 4ac2520b25b7e7056600034e
  # To   ... e4300066507e7b52b0252ca4
  def mangle(string)
    result = string.reverse
    raise "mangle failed" if result == string
    result
  end
end

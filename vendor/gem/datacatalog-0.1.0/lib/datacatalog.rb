require 'rubygems'
require 'httparty'
require 'activesupport'
require 'mash'

module DataCatalog
  mattr_accessor :api_key, :base_uri
  class Error                     < RuntimeError; end
  class BadRequest                < Error; end # 400
  class Unauthorized              < Error; end # 401
  class Forbidden                 < Error; end # 403
  class NotFound                  < Error; end # 404
  class InternalServerError       < Error; end # 500
  class ApiKeyNotConfigured       < Error; end
  class CannotDeletePrimaryApiKey < Error; end
  
  def self.with_key(temp_key)
    original_key = DataCatalog.api_key 
    DataCatalog.api_key = temp_key
    yield
    DataCatalog.api_key = original_key
  end
  
end

require "#{File.dirname(__FILE__)}/datacatalog/base.rb"
Dir["#{File.dirname(__FILE__)}/datacatalog/*.rb"].each { |source_file| require source_file }
ENV["RAILS_ENV"] = "cucumber"

require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'cucumber/formatter/unicode'
require 'webrat'
require 'cucumber/rails/rspec'
require 'webrat/core/matchers'

ActionController::Base.class_eval do

  private

  def begin_open_id_authentication(identity_url, options = {})
    yield OpenIdAuthentication::Result.new(:successful), normalize_identifier(identity_url), nil
  end
  
end

Before do
  DataCatalog::User.all.each do |u|
    DataCatalog::User.destroy(u.id) unless u.name == "Primary Admin"
  end
  
  DataCatalog::Source.all.each do |s|
    DataCatalog::Source.destroy(s.id)
  end
end

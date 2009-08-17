require Rails.root.to_s + "/lib/utilities"

config.cache_classes = true

config.whiny_nils = true
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false
config.action_controller.allow_forgery_protection    = false
config.action_mailer.delivery_method = :test

config.gem "cucumber",                          :version => ">=0.3.94"  unless "cucumber".plugin?
config.gem "webrat",                            :version => ">=0.4.5"   unless "webrat".plugin?
config.gem "rspec",       :lib => false,        :version => ">=1.2.6"   unless "rspec".plugin?
config.gem "rspec-rails", :lib => 'spec/rails', :version => ">=1.2.6"   unless "rspec-rails".plugin?

# Be sure to restart your server when you modify this file.

file = File.expand_path(File.dirname(__FILE__) + "/../api.yml")
api_config = YAML.load_file(file)
api_config_env = api_config[RAILS_ENV]
unless api_config_env
  raise %(Environment "#{RAILS_ENV}" not found in #{file})
end
unless api_config_env['api_key']
  raise %(api_key not found for environment "#{RAILS_ENV}" in #{file})
end
unless api_config_env['base_uri']
  raise %(base_uri not found for environment "#{RAILS_ENV}" in #{file})
end
DataCatalog.api_key  = api_config_env['api_key']
DataCatalog.base_uri = api_config_env['base_uri']

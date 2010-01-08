# Be sure to restart your server when you modify this file.

dc_config = YAML.load_file(File.dirname(__FILE__) + "/../api.yml")

DataCatalog.api_key   = dc_config[RAILS_ENV]['api_key']
DataCatalog.base_uri  = dc_config[RAILS_ENV]['base_uri']
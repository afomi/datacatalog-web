module DataCatalog

  class Base < Mash
  
    include HTTParty
    format :json
    
    def self.set_base_uri
      default_options[:base_uri] = HTTParty.normalize_base_uri(DataCatalog.base_uri || 'api.nationaldatacatalog.com')
    end
    
    def self.set_api_key
      if DataCatalog.api_key.blank?
        raise ApiKeyNotConfigured, "Use DataCatalog.api_key = '...'"
      end
      default_options[:default_params] = {} if default_options[:default_params].nil?
      default_options[:default_params].merge!({:api_key => DataCatalog.api_key})
    end

    def self.set_up!
      set_base_uri
      set_api_key
    end

    def self.check_status_code(response)
      case response.code
      when 400: raise BadRequest, error_message(response)
      when 401: raise Unauthorized, error_message(response)
      when 403: raise Forbidden, error_message(response)
      when 404: raise NotFound, error_message(response)
      when 409: raise Conflict, error_message(response)
      when 500: raise InternalServerError, error_message(response)
      end
    end
    
    def self.error_message(response)
      parsed_body = JSON.parse(response.body)
      
      if parsed_body.empty?
        return "Response was empty"
      elsif parsed_body["errors"]
        return parsed_body["errors"].inspect
      else
        return response.body
      end
      
      rescue JSON::ParserError
        return "Unable to parse: #{response.body.inspect}"
    end

    def self.response_for
      response = yield
      check_status_code(response)
      response
    end

    def self.build_object(response)
      return nil if response.nil? || response.empty?
      new(response)
    end

    def self.about
      default_options[:default_params] = {}
      set_base_uri
      build_object(response_for{get('/')})
    end

  end # class Base

end # module DataCatalog
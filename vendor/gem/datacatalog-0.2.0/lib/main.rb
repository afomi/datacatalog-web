module DataCatalog
  
  # == Exceptions
  
  class Error                     < RuntimeError; end
  class BadRequest                < Error; end # 400
  class Unauthorized              < Error; end # 401
  class Forbidden                 < Error; end # 403
  class NotFound                  < Error; end # 404
  class Conflict                  < Error; end # 409
  class InternalServerError       < Error; end # 500
  class ApiKeyNotConfigured       < Error; end
  class CannotDeletePrimaryApiKey < Error; end
  
  # == Accessors
  
  def self.api_key
    Base.default_params[:api_key]
  end
  
  def self.api_key=(key)
    Base.default_params :api_key => key
  end
  
  def self.base_uri
    Base.base_uri
  end
  
  def self.base_uri=(uri)
    Base.base_uri(uri.blank? ? Base::DEFAULT_BASE_URI : uri)
  end
  
  def self.with_key(temp_key)
    original_key = DataCatalog.api_key
    DataCatalog.api_key = temp_key
    yield
    DataCatalog.api_key = original_key
  end

end

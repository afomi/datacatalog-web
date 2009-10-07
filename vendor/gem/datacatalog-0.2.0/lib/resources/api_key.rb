module DataCatalog

  class ApiKey < Base
    
    attr_accessor :user
    
    def self.all(user_id, conditions={})
      raise Error, "user_id cannot be blank" if user_id.blank?
      many(http_get("/users/#{user_id}/keys", :query => conditions))
    end
    
  end

end

module DataCatalog

  class ApiKey < Base
    
    def self.all(user_id, conditions={})
      many(http_get(uri(user_id), :query => conditions))
    end

    def self.create(user_id, params={})
      one(http_post(uri(user_id), :query => params))
    end

    def self.destroy(user_id, id)
      one(http_delete(uri(user_id, id)))
    end

    def self.first(user_id, conditions={})
      one(http_get(uri(user_id), :query => conditions).first)
    end

    def self.get(user_id, id)
      one(http_get(uri(user_id, id)))
    end
    
    def self.update(user_id, id, params={})
      one(http_put(uri(user_id, id), :query => params))
    end
    
    # == Helpers
    
    def self.uri(user_id, id = nil)
      raise Error, "user_id cannot be blank" if user_id.blank?
      "/users/#{user_id}/keys/#{id}"
    end
    
  end

end

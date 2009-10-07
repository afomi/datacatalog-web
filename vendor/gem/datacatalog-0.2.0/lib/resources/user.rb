module DataCatalog

  class User < Base
    
    def self.all(conditions={})
      many(http_get("/users", :query => conditions))
    end

    def self.create(params={})
      with_api_keys(one(http_post("/users", :query => params)))
    end

    def self.destroy(user_id)
      one(http_delete("/users/#{user_id}"))
    end

    def self.get_by_api_key(api_key)
      DataCatalog.with_key(api_key) do
        user_id = one(http_get("/checkup")).user.id
        get(user_id)
      end
    end

    def self.first(conditions={})
      one(http_get("/users", :query => conditions).first)
    end
    
    def self.get(id)
      with_api_keys(one(http_get("/users/#{id}")))
    end

    def self.get_by_api_key(api_key)
      DataCatalog.with_key(api_key) do
        checkup = one(http_get("/checkup"))
        raise NotFound unless checkup.valid_api_key
        get(checkup.user.id)
      end
    end
    
    def self.update(user_id, params)
      one(http_put("/users/#{user_id}", :query => params))
    end

    # == Helpers
    
    def self.with_api_keys(user)
      user.api_keys = ApiKey.all(user.id) if user
      user
    end
    
    # == Instance Methods

    def delete_api_key!(api_key_id)
      ApiKey.destroy(self.id, api_key_id)
      update_api_keys
    end

    def generate_api_key!(params)
      ApiKey.create(self.id, params)
      update_api_keys
    end

    def update_api_key!(api_key_id, params)
      ApiKey.update(self.id, api_key_id, params)
      update_api_keys
    end
    
    protected
    
    def update_api_keys
      self.api_keys = ApiKey.all(self.id)
      user = User.get(id)
      self.application_api_keys = user.application_api_keys
      self.valet_api_keys = user.valet_api_keys
      true
    end
    
  end

end

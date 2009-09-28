module DataCatalog

  class User < DataCatalog::Base
    
    def self.all
      set_up!
      response_for{ get("/users") }.map do |user|
        build_object(user)
      end
    end
    
    def self.find(id)
      set_up!
      user = build_object(response_for { get("/users/#{id}") })
      user.api_keys = response_for { get("/users/#{id}/keys") }.map do |key|
        DataCatalog::ApiKey.build_object(key)
      end if user
      user
    end
    
    def self.find_by_api_key(api_key)
      user = nil
      DataCatalog.with_key(api_key) do
        set_up!
        checkup = build_object(response_for { get("/checkup") })
        user = find(checkup.user_id)
      end
      user
    end
    
    def self.create(params={})
      set_up!
      user = build_object(response_for { post("/users", :query => params) })
      user.api_keys = response_for { get("/users/#{user.id}/keys") }.map do |key|
        DataCatalog::ApiKey.build_object(key)
      end if user
      user
    end

    def self.update(user_id, params)
      set_up!
      build_object(response_for { put("/users/#{user_id}", :query => params) })
    end
    
    def self.destroy(user_id)
      set_up!
      response = response_for { delete("/users/#{user_id}") }
      true
    end
    
    def generate_api_key!(params)
      self.class.set_up!
      
      response = self.class.response_for do
        self.class.post("/users/#{self.id}/keys", :query => params )
      end
      update_api_keys
      true
    end
    
    def delete_api_key!(api_key_id)
      self.class.set_up!
      
      response = self.class.response_for do
        self.class.delete("/users/#{self.id}/keys/#{api_key_id}")
      end
      update_api_keys
      true
    end
    
    def update_api_key!(api_key_id, params)
      self.class.set_up!
      
      response = self.class.response_for do
        self.class.put("/users/#{self.id}/keys/#{api_key_id}", :query => params)
      end
      update_api_keys
      true
    end
    
    private
    
    def update_api_keys
      self.api_keys = self.class.response_for { self.class.get("/users/#{self.id}/keys") }.map do |key|
        DataCatalog::ApiKey.build_object(key)
      end
      updated_user = DataCatalog::User.find(self.id)
      self.application_api_keys = updated_user.application_api_keys
      self.valet_api_keys = updated_user.valet_api_keys
    end
    
  end # class User

end # module DataCatalog
module DataCatalog

  class User < DataCatalog::Base
  
    include HTTParty
    format :json

    attr_reader :api_keys
    def api_keys=(value) raise NoMethodError end
    
    def self.all
      set_up!
      response_for{ get("/users") }.map do |user|
        build_object(user)
      end
    end
    
    def self.find(id)
      set_up!
      build_object(response_for { get("/users/#{id}") })
    end
    
    def self.create(params={})
      set_up!
      build_object(response_for { post("/users", :query => params) })
    end

    def self.update(user_id, params)
      set_up!
      build_object(response_for { put("/users/#{user_id}", :query => params) })
    end
    
    def self.destroy(user_id)
      set_up!
      response = response_for { delete("/users/#{user_id}") }
      raise Error, "Unexpected Status Code" unless response.code == 200
      true
    end
    
    def generate_api_key(purpose)
      self.class.set_up!

      response = self.class.response_for do
        self.class.post("/users/#{self.id}/api_keys", :query => { :purpose => purpose })
      end
      
      @api_keys ||= []
      @api_keys << response
    end

    def secondary_api_keys
      raise UserHasNoApiKeys if @api_keys.nil? || @api_keys.empty?
      @api_keys[1..-1]
    end
    
    def delete_api_key(api_key)
      self.class.set_up!
      response = self.class.response_for do
        self.class.delete("/users/#{self.id}/api_keys/#{api_key}")
      end
      @api_keys.delete_if { |key| key.api_key == api_key }
      true
    end
    
  end # class User

end # module DataCatalog

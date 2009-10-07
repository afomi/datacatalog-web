module DataCatalog

  class About < Base
    
    def self.get()
      one(http_get("/"))
    end
    
  end
  
end

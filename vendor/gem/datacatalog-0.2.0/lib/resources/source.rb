module DataCatalog

  class Source < Base
    
    def self.all(conditions={})
      many(http_get("/sources", :query => conditions))
    end

    def self.create(params={})
      one(http_post("/sources", :query => params))
    end

    def self.destroy(source_id)
      one(http_delete("/sources/#{source_id}"))
    end
    
    def self.first(conditions={})
      one(http_get("/sources", :query => conditions).first)
    end

    def self.get(id)
      one(http_get("/sources/#{id}"))
    end
    
    def self.update(source_id, params={})
      one(http_put("/sources/#{source_id}", :query => params))
    end

  end
  
end

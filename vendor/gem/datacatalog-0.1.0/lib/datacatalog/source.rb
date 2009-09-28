module DataCatalog

  class Source < DataCatalog::Base
    
    def self.create(params={})
      set_up!
      build_object(response_for { post("/sources", :query => params) })
    end
    
    def self.all
      set_up!
      response_for{ get("/sources") }.map do |source|
        build_object(source)
      end
    end
    
    def self.update(source_id, params={})
      set_up!
      build_object(response_for { put("/sources/#{source_id}", :query => params) })
    end
  
    def self.destroy(source_id)
      set_up!
      response = response_for { delete("/sources/#{source_id}") }
      true
    end
    
  end
  
end
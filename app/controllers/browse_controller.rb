class BrowseController < ApplicationController
  
  def index
    @sources = DataCatalog::Source.all
    @pages = paginate(@sources)
    @organizations = CACHE.get(:active_organizations)
  end
  
end
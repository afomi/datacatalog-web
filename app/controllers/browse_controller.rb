class BrowseController < ApplicationController
  
  def index
    @sources = DataCatalog::Source.all
    @pages = paginate(@sources)
  end
  
end
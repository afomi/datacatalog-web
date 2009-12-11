class SearchController < ApplicationController

  RADIUS = 3
  
  def index
    @term = params[:term]
    @sources = @term.blank? ? [] : DataCatalog::Source.search(@term)
    @pages = paginate(@sources)
  end
  
end
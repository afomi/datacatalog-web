class SearchController < ApplicationController
  
  def index
    @term = params[:term]
    @sources = @term.blank? ? [] : DataCatalog::Source.search(@term)
  end
  
end
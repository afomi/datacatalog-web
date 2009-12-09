class SearchController < ApplicationController
  
  def index
    @term = params[:term]
    @sources = @term.blank? ? [] : DataCatalog::Source.search(@term)
    @page = params[:page].nil? ? 1 : params[:page].to_i
  end
  
end
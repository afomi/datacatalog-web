class SearchController < ApplicationController

  RADIUS = 3
  
  def index
    @term = params[:term]
    if @term.blank?
      redirect_to :back
    else
      @sources = DataCatalog::Source.search(@term)
      @pages = paginate(@sources)
    end
  end
  
end
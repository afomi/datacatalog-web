class BrowseController < ApplicationController
  
  def index

    @sources = DataCatalog::Source.all
    @page = params[:page] || 1

  end
  
end
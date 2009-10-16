class BrowseController < ApplicationController
  
  def index

    @sources = DataCatalog::Source.all

  end
  
end
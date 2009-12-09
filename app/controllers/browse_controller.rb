class BrowseController < ApplicationController
  
  def index

    @sources = DataCatalog::Source.all
    @page = params[:page].to_i || 1

  end
  
end
class BrowseController < ApplicationController
  
  def index
    @sources = DataCatalog::Source.all
    @page = params[:page].nil? ? 1 : params[:page].to_i
  end
  
end
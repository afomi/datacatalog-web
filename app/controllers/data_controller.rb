class DataController < ApplicationController
  
  def show
    @source = DataCatalog::Source.first(:slug => params[:slug])
  end
  
  
end
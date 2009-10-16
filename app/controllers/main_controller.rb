class MainController < ApplicationController
  
  def dashboard

  end
  
  def about
    
  end
  
  def source
    
    @source = DataCatalog::Source.get(params[:slug])
    
  end
  
  
end

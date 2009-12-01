class MainController < ApplicationController
  
  def dashboard
    if current_user
      render 'dashboard' and return
    else
      render 'welcome' and return
    end
  end
  
  def about
    
  end
  
  def source
    
    @source = DataCatalog::Source.get(params[:slug])
    
  end
  
  
end

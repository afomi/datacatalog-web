class OrgController < ApplicationController
  before_filter :require_user, :except => [:show]
  
  def show
    @org = DataCatalog::Organization.first(:slug => params[:slug])
    @sources = find_sources(@org)
    @pages = paginate(@sources)
    @clear = false
  end
  
  protected
  
  def find_sources(org)
    if @org.top_level
      DataCatalog::Source.all(:jurisdiction_id => @org.id)
    else
      DataCatalog::Source.all(:organization_id => @org.id)
    end
  end
  
end
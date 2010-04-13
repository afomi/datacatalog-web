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
    key = @org.top_level ? :jurisdiction_id : :organization_id
    DataCatalog::Source.all(key => @org.id)
  end
  
end
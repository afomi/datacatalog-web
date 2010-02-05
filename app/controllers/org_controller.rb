class OrgController < ApplicationController
  before_filter :require_user, :except => [:show]
  
  def show
    @org = DataCatalog::Organization.first(:slug => params[:slug])
    @sources = DataCatalog::Source.all(:organization_id => @org.id)
    @pages = paginate(@sources)
    @clear = false
  end
  
end
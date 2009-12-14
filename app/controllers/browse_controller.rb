class BrowseController < ApplicationController
  
  def index
    @sources = DataCatalog::Source.all
    @pages = paginate(@sources)
    @organizations = get_organizations
  end
  
  protected
  
  def get_organizations
    orgs = CACHE.get(:active_organizations)
    if orgs.empty?
      [['Data is loading...', 0]]
    else
      [['All', 'all']].concat(orgs)
    end
  end
  
end
class Admin::SourcesController < AdminController
  
  def index
    @sources = DataCatalog::Source.all
  end
  
end
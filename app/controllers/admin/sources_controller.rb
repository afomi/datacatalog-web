class Admin::SourcesController < AdminController
  
  def index
    @sources = DataCatalog::Source.all.sort { |a,b| a.title <=> b.title }
  end
  
end
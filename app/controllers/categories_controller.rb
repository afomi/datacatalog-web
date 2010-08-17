class CategoriesController < ApplicationController

  def index
    @categories = DataCatalog::Category.all
  end
  
  def show
    @sources = get_filtered_sources
    @pages = paginate(@sources)
  end
  
  def edit
    #not yet implemented
    redirect_to categories_path
  end
  
  def new
    # not yet implemented
    redirect_to categories_path
  end
  
  def destroy
    #not yet implemented
    redirect_to categories_path
  end

  protected

  def get_filtered_sources
    conditions = {}
    if params[:id]
      conditions[:source_categories] = params[:id]
    end
    DataCatalog::Source.all(conditions)
  end
  
end

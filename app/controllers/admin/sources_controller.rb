class Admin::SourcesController < AdminController
  
  def index
    @sources = DataCatalog::Source.all.sort { |a,b| a.title <=> b.title }
  end
  
  def edit
    @source = DataCatalog::Source.first(:slug => params[:id])
  end
  
  def new
    @source = DataCatalog::Source.new
  end
  
  def create    
    @source = DataCatalog::Source.new(params[:source])

    begin
      source = DataCatalog::Source.create(params[:source])
      flash[:notice] = "Source created!"
      redirect_to admin_source_path(source.slug)
    rescue DataCatalog::BadRequest => e
      flash[:error] = build_error_msg(e)
      render :new
    end
  end

  def update
    @source = DataCatalog::Source.get(params[:id])
    @source.update(params[:source])
    
    begin
      source = DataCatalog::Source.update(params[:id], params[:source])
      flash[:notice] = "Source saved!"
      redirect_to edit_admin_source_path(params[:source][:slug])
    rescue DataCatalog::BadRequest => e
      flash[:error] = build_error_msg(e)
      render :edit
    end
  end
  
end
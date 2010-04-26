class Admin::SourcesController < AdminController
  
  KRONOS_FIELDS = [:released, :period_start, :period_end]
  
  before_filter :get_organizations, :set_frequencies
  
  def index
    @sources = DataCatalog::Source.all
    @pages = paginate(@sources)
  end
  
  def edit
    @source = DataCatalog::Source.first(:slug => params[:id])
    KRONOS_FIELDS.each do |key|
      @source[key] = Kronos.from_hash(@source[key]).to_s
    end
  end
  
  def new
    @source = DataCatalog::Source.new
  end
  
  def create
    KRONOS_FIELDS.each do |key|
      params[:source][key] = Kronos.parse(params[:source][key]).to_hash
    end    
    @source = DataCatalog::Source.new(params[:source])
    begin
      source = DataCatalog::Source.create(params[:source])
      flash[:notice] = "Source created!"
      redirect_to edit_admin_source_path(source.slug)
    rescue DataCatalog::BadRequest => e
      flash[:error] = build_error_message(e.errors)
      render :new
    end
  end

  def update
    @source = DataCatalog::Source.get(params[:id])
    KRONOS_FIELDS.each do |key|
      params[:source][key] = Kronos.parse(params[:source][key]).to_hash
    end
    @source.update(params[:source])
    
    begin
      source = DataCatalog::Source.update(params[:id], params[:source])
      flash[:notice] = "Source saved!"
      redirect_to edit_admin_source_path(params[:source][:slug])
    rescue DataCatalog::BadRequest => e
      flash[:error] = build_error_message(e.errors)
      render :edit
    end
  end
  
  protected
  
  def get_organizations
    orgs = CACHE.get(:organizations)
    @organizations = if orgs
      orgs
    else
      [['Data is loading...', 0]]
    end
  end
  
  def set_frequencies
    @frequencies = [
        "each second"  ,
        "each minute"  ,
        "each hour"    ,
        "each day"     ,
        "each week"    ,
        "each month"   ,
        "each quarter" ,
        "each year"    ,
        "hourly"       ,
        "daily"        ,
        "weekly"       ,
        "fortnightly"  ,
        "monthly"      ,
        "quarterly"    ,
        "biannually"   ,
        "semiannual"   ,
        "semi-annual"  ,
        "semiannually" ,
        "annual"       ,
        "annually"     ,
        "yearly"       ,
        "biennial"     ,
        "biennially"   ,
        "quadrennial"  ,
        "quadrennially",
        "decade"       ,
        "one time"     ,
        "one-time"     ,
        "other"        ,
        "unknown"]
  end
  
end

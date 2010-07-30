class Admin::OrganizationsController < AdminController

  before_filter :get_parents

  def index
    @organizations = DataCatalog::Organization.all
    @pages = paginate(@organizations)
  end

  def show
    @organization = DataCatalog::Organization.first(:slug => params[:id])
  end

  def new
    @organization = DataCatalog::Organization.new
  end

  def create
    @organization = DataCatalog::Organization.new(
      params[:organization])
    begin
      organization = DataCatalog::Organization.create(params[:organization])
      flash[:notice] = "Organization created!"
      redirect_to admin_organization_path(organization.slug)
    rescue DataCatalog::BadRequest => e
      flash[:error] = build_error_message(e.errors)
      render :new
    end
  end

  def update
    @organization = DataCatalog::Organization.get(params[:id])
    @organization.update(params[:organization])
    begin
      organization = DataCatalog::Organization.update(
        params[:id], params[:organization])
      flash[:notice] = "Organization saved!"
      redirect_to admin_organization_path(params[:organization][:slug])
    rescue DataCatalog::BadRequest => e
      flash[:error] = build_error_message(e.errors)
      render :show
    end
  end

  protected

  def get_parents
    orgs = CACHE.get(:organizations)
    @parents = if orgs
      orgs
    else
      [['Data is loading...', 0]]
    end
  end

end

class Admin::OrganizationsController < AdminController
  
  def index
    @organizations = DataCatalog::Organization.all.sort { |a,b| a.name <=> b.name }
  end
  
  def show
    @organization = DataCatalog::Organization.first(:slug => params[:id])
  end

  def new
    @organization = DataCatalog::Organization.new
  end

  def create
    handle_api_errors do
      @organization = DataCatalog::Organization.create(params[:organization])
      flash[:notice] = "Organization created!"
      redirect_to admin_organization_path(@organization.id)
    end
  end

  def update
    handle_api_errors do
      @organization = DataCatalog::Organization.update(params[:id], params[:organization])
      flash[:notice] = "Organization saved!"
      redirect_to admin_organization_path(params[:id])
    end
  end
  
end
class Admin::DownloadsController < AdminController
  before_filter :find_source

  def new
    @download = DataCatalog::Download.new
    @download['size'] = {}
  end

  def create
    if params[:download][:size][:number].blank?
      params[:download].delete(:size)
    else
      params[:download][:size][:bytes] =
        params[:download][:size][:number].to_i *
        (2 ** power_of(params[:download][:size][:unit]))
    end
    params[:download][:source_id] = params[:source_id]
    @download = DataCatalog::Download.new(params[:download])
    @source = DataCatalog::Source.get(params[:source_id])
    begin
      download = DataCatalog::Download.create(params[:download])
      flash[:notice] = "Download created!"
      redirect_to edit_admin_source_download_path(@source.slug, download.id)
    rescue DataCatalog::BadRequest => e
      flash[:error] = build_error_message(e.errors)
      render :new
    end
  end

  def edit
    @download = DataCatalog::Download.get(params[:id])
  end

  def update
    @source = DataCatalog::Source.get(params[:source_id])
    @download = DataCatalog::Download.get(params[:id])
    if params[:download][:size][:number].blank?
      params[:download].delete(:size)
    else
      params[:download][:size][:bytes] =
        params[:download][:size][:number].to_i *
        (2 ** power_of(params[:download][:size][:unit]))
    end
    begin
      download = DataCatalog::Download.update(params[:id], params[:download])
      flash[:notice] = "Download saved!"
      redirect_to edit_admin_source_download_path(@source.slug, @download.id)
    rescue DataCatalog::BadRequest => e
      flash[:error] = build_error_message(e.errors)
      render :edit
    end
  end

  def destroy
    @download = DataCatalog::Download.get(params[:id])
    @source = DataCatalog::Source.get(@download.source_id)
    DataCatalog::Download.destroy(params[:id])
    redirect_to edit_admin_source_path(@source.slug)
  end

  protected

  def find_source
    @source = DataCatalog::Source.first(:slug => params[:source_id])
  end

  def power_of(unit)
    return case unit
      when 'B'  then 0
      when 'KB' then 10
      when 'MB' then 20
      when 'TB' then 30
      when 'PB' then 40
      when 'PB' then 50
      else 0
    end
  end

end

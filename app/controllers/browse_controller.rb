class BrowseController < ApplicationController

  def index
    @cacheable_params = params.dup.delete_if do |key, value|
      %w(action controller reload).include?(key) || value == 'all'
    end
    filter_form_setup
    if !params[:reload].blank?
      expire_fragment(@cacheable_params)
      browse_setup
    elsif !read_fragment(@cacheable_params)
      browse_setup
    end
  end
  
  protected
  
  def browse_setup
    @sources = get_filtered_sources
    @pages = paginate(@sources)
  end
  
  def get_filtered_sources
    conditions = {}
    if @filters[:organization_id]
      conditions[:organization_id] = @filters[:organization_id]
    end
    if @filters[:source_type]
      conditions[:source_type] = @filters[:source_type]
    end
    if @filters[:release_year]
      conditions['released.year'] = @filters[:release_year].to_i
    end
    DataCatalog::Source.all(conditions)
  end
  
  def get_filters(list)
    filters = {}
    list.each do |item|
      param = params[item]
      filters[item] = param if param && param != 'all'
    end
    filters
  end
  
  def filter_form_setup
    @filters = get_filters([:organization_id, :source_type, :release_year])
    @organizations = get_organizations
    @source_types  = get_source_types
    @release_years = get_release_years
  end
  
  def get_organizations
    orgs = CACHE.get(:active_organizations)
    if orgs
      [['All', 'all']].concat(orgs)
    else
      [['Data is loading...', 0]]
    end
  end
  
  def get_source_types
    %w(All Dataset API).map { |s| [s, s.downcase] }
  end
  
  def get_release_years
    years = Time.now.year.downto(1950).map { |y| [y, y] }
    [['All', 'all']].concat(years)
  end
  
end
class Cache
  
  CACHE_PATH = "#{RAILS_ROOT}/tmp/dj_cache/"

  LABELS = %w(
    organizations
    active_organizations
  )
  
  def get(label, cache_invalid_after=3600)
    if cache_invalid?(label)
      self.send_later(:run_query, label)
    end
    load_from_file(label)
  end
  
  protected
  
  def cache_invalid?(label, cache_life=3600)
    f_name = filename(label)
    return true unless File.exist?(f_name)
    modified_at = File.mtime(f_name)
    (Time.now - modified_at) > cache_life
  end
  
  def run_query(label)
    logger = Delayed::Worker.logger
    o1 = case label
    when :organizations
      logger.info "Loading all organizations..."
      DataCatalog::Organization.all
    when :active_organizations
      logger.info "Loading organizations with at least one source..."
      DataCatalog::Organization.all('source_count > 0')
    else
      raise RuntimeError, "label not found : #{label}"
    end
    # logger.info "Building array with name and id..."
    o2 = o1.map { |o| [o.name, o.id] }
    # logger.info "Sorting array..."
    o3 = o2.sort_by { |x| x[0] }
    # logger.info "Saving..."
    write_to_file(label, o3)
    logger.info "Done."
  end
  
  def filename(label)
    if LABELS.include?(label.to_s)
      File.join(CACHE_PATH, "#{label}.yaml")
    else
      raise "label not found : #{label}"
    end
  end
  
  def write_to_file(label, object)
    f_name = filename(label)
    FileUtils.mkdir_p(File.dirname(f_name))
    File.open(f_name, 'w') do |file|
      YAML.dump(object, file)
    end
  end
  
  def load_from_file(label)
    f_name = filename(label)
    return nil unless File.exist?(f_name)
    YAML.load_file(f_name)
  end

end

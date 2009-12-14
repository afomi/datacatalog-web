class Cache

  def initialize
    @queued = {}
  end

  LABELS = %w(
    organizations
    active_organizations
  )
  
  DATA_LOADING = [['Data is loading...', 0]]

  def get(label, cache_invalid_after=3600)
    cache = load_from_file(label)
    if !cache || cache_expired?(label)
      run_unless_already_queued(label)
    end
    cache ? cache : DATA_LOADING
  end
  
  protected
  
  def cache_expired?(label, cache_life=3600)
    modified_at = File.mtime(filename(label))
    (Time.now - modified_at) > cache_life
  end
  
  def run_unless_already_queued(label)
    if !@queued[label]
      self.send_later(:run_query, label)
      @queued[label] = true
    else
      puts "#{label} is already in the queue"
    end
  end
  
  def run_query(label)
    o1 = case label
    when :organizations
      puts "Loading all organizations..."
      DataCatalog::Organization.all
    when :active_organizations
      puts "Loading organizations with at least one source..."
      DataCatalog::Organization.all('source_count > 0')
    else
      raise RuntimeError, "label not found : #{label}"
    end
    puts "Building array with name and id..."
    o2 = o1.map { |o| [o.name, o.id] }
    puts "Sorting array..."
    o3 = o2.sort_by { |x| x[0] }
    puts "Saving..."
    write_to_file(label, o3)
    puts "Done."
    @queued[label] = false
  end
  
  def filename(label)
    if LABELS.include?(label.to_s)
      "#{RAILS_ROOT}/tmp/dj_cache/#{label}.yaml"
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
class Cache
  
  def organizations
    orgs = load_organizations
    return orgs if orgs
    run_later(:generate_and_save_organizations)
    [['Data is loading...', 0]]
  end
  
  protected
  
  def run_later(method, refresh=3_600)
    if !@last_run || (Time.now - @last_run) > refresh
      self.send_later(method)
      @last_run = Time.now
    else
      puts "The job is queued. Patience, grasshopper."
    end
  end
  
  def generate_and_save_organizations
    puts "Loading organizations..."
    o1 = DataCatalog::Organization.all
    o2 = o1.map { |o| [o.name, o.id] }
    puts "Organizations are loaded."
    o3 = o2.sort_by { |x| x[0] }
    puts "Organizations are sorted."
    save_organizations(o3)
    puts "Organizations are saved to disk."
  end
  
  FILENAME = "#{RAILS_ROOT}/tmp/cache/organizations.yaml"
  def save_organizations(orgs)
    File.open(FILENAME, 'w') do |out|
      YAML.dump(orgs, out )
    end
  end
  
  def load_organizations
    return nil unless File.exist?(FILENAME)
    @organizations = YAML.load_file(FILENAME)
  end

end

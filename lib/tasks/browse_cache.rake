namespace :browse_cache do
  desc "Refresh the /browse cache"
  task :refresh do
    require 'open-uri'
    env = ENV['RAILS_ENV'] || 'development'
    config_file = File.join(File.dirname(__FILE__), "/../../config/server.yml")
    config = YAML.load_file(config_file)
    base_uri = config[env]['base_uri']
    puts "Refreshing /browse cache on #{base_uri}..."
    page = 1
    loop do
      begin
        print "  * page %3i" % page
        status, t = fetch_page(base_uri, page)
        puts "  %s  %4.0f ms" % [status.join(" "), t * 1000]
        page += 1
      rescue OpenURI::HTTPError
        puts "  404 Not Found"
        break
      end
    end
  end
  
  def time_block
    t = Time.now
    yield
    Time.now - t
  end
  
  def fetch_page(base_uri, page)
    status = nil
    uri = URI.join(base_uri, "/browse?page=#{page}&reload=true")
    t = time_block do 
      open(uri) { |f| status = f.status }
    end
    [status, t]
  end
  
end

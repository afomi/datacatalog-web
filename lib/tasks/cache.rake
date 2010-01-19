namespace :cache do
  
  namespace :browse do
  
    desc "Refresh the cache"
    task :refresh => [:expire_filtered, :refresh_unfiltered]

    # desc "Expire the filtered /browse pages"
    task :expire_filtered => :environment do
      controller = ActionController::Base.new
      %w(organization_id source_type release_year).each do |key|
        puts "Refreshing /browse fragment caches that match #{key}..."
        controller.expire_fragment(/browse\..*#{key}.*/)
      end
    end

    # desc "Refresh the main /browse pages"
    task :refresh_unfiltered do
      base_uri = get_base_uri
      puts "Refreshing /browse fragment cache on #{base_uri}..."
      require 'open-uri'
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
  
    def get_base_uri
      env = ENV['RAILS_ENV'] || 'development'
      config_file = File.join(File.dirname(__FILE__), "/../../config/server.yml")
      config = YAML.load_file(config_file)
      config[env]['base_uri']
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

end

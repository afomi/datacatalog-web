begin
  require 'delayed/tasks'
rescue LoadError
  STDERR.puts "Run `rake gems:install` to install delayed_job"
end

namespace :jobs do
  namespace :cache do
    desc "Clear delayed_job temporary files"
    task :clear do
      require "#{RAILS_ROOT}/lib/cache"
      s = File.join(Cache::CACHE_PATH, '*')
      puts "rm #{s}"
      FileUtils.rm(Dir.glob(s))
    end
  end
end

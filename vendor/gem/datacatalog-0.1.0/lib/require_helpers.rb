PROJECT_ROOT = File.dirname(__FILE__)

def require_dir(dir)
  Dir.glob(make_full_path(dir) + "/*.rb").each { |f| require f }
end

def load_dir(dir, pattern)
  Dir.glob(make_full_path(dir) + "/#{pattern}").each { |f| load f }
end

def require_file(filename)
  require make_full_path(filename)
end

def make_full_path(filename)
  File.expand_path(File.join(PROJECT_ROOT, filename))
end

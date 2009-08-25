Gem::Specification.new do |s|
  s.name = "datacatalog"
  s.version = "0.1.0"
  s.date = "2009-08-15"
  s.summary = "Library for accessing the National Data Catalog."
  s.description = "Library for accessing the National Data Catalog."
  s.rubyforge_project = "datacatalog"
  s.email = "luigi@sunlightfoundation.com"
  s.homepage = "http://github.com/sunlightlabs/ruby-datacatalog/"
  s.authors = ["Luigi Montanez"]
  s.files = ['datacatalog.gemspec', 'lib/datacatalog.rb', 'lib/datacatalog/base.rb',
             'lib/datacatalog/user.rb', 'lib/datacatalog/source.rb', 'lib/datacatalog/api_key.rb', 
             'README.md', 'CHANGES.md']
  s.add_dependency("httparty", [">= 0.4.4"])
  s.has_rdoc = true
end
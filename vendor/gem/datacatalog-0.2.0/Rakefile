require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "datacatalog"
    gem.rubyforge_project = "datacatalog"
    gem.summary = %Q{Wrapper for the National Data Catalog API}
    gem.description = %Q{Ruby library that wraps the National Data Catalog API}
    gem.email = "luigi@sunlightfoundation.com"
    gem.homepage = "http://github.com/sunlightlabs/datacatalog"
    gem.authors = ["Luigi Montanez", "David James"]
    gem.add_dependency('activesupport', ">= 2.3.4")
    gem.add_dependency('httparty', ">= 0.4.5")
    gem.add_dependency('mash', ">= 0.0.3")
    gem.add_development_dependency("jeweler", ">= 1.2.1")
    gem.add_development_dependency("rspec", ">= 1.2.8")
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_opts = ['--color']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.rcov = true
  spec.rcov_opts = ['--exclude', '^spec,/gems/']
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "datacatalog #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

default_run_options[:pty] = true

set :environment, (ENV['target'] || 'staging')
set :application, "datacatalog-web"
set :repository,  "git@github.com:sunlightlabs/datacatalog-web.git"
set :scm, "git"
set :user, "datcat"
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/www/#{application}"
set :domain, "nationaldatacatalog.com"

if environment == 'production'
  set :domain, 'nationaldatacatalog.com'
  set :branch, 'production'
else
  set :domain, 'staging.nationaldatacatalog.com'
  set :branch, 'master'
end

role :web, domain
role :app, domain
role :db,  domain, :primary => true 

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :symlink_config do
    shared_config = File.join(shared_path, 'config')
    release_config = "#{release_path}/config"
    %w{analytics api database mail_settings server}.each do |file|
      run "ln -s #{shared_config}/#{file}.yml #{release_config}/#{file}.yml"
    end
  end
  
  task :symlink_delayed_job do
    shared = File.join(shared_path, 'tmp/dj_cache')
    release = "#{release_path}/tmp/dj_cache"
    run "ln -s #{shared} #{release}"
  end
  
  task :restart_delayed_job do
    run "cd #{current_path}; RAILS_ENV=production rake jobs:cache:clear"
    run "cd #{current_path}; RAILS_ENV=production script/delayed_job restart"
  end
end

after 'deploy:update_code' do
  deploy.symlink_config
  deploy.symlink_delayed_job
end

before 'deploy:restart' do
  deploy.restart_delayed_job
end

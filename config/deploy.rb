require "bundler/capistrano"
require "rvm/capistrano"     

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :domain, "worklog.kmpgroup.pl"
set :bundle_flags, ""
set :bundle_dir, nil
set :user, "worklog"
set :rvm_ruby_string, 'ruby-1.9.3-p392@worklog'   
role :app, domain
role :web, domain
role :db, domain, :primary => true

set :application, "KMP TimeMonitor"

set :scm, :git
set :scm_password, "pDe86k"
set :deploy_via, :remote_cache
set :use_sudo, false
set :repository, "ssh://redmine@redmine.kmpgroup.pl/~/redmine/repositories/worklog.git"

server 'worklog.kmpgroup.pl', :app, :web, :primary => true
set :deploy_env, 'production'
set :rails_env, 'production'
set :branch, "master"
set :deploy_to, "/home/worklog/www/production"

namespace :deploy do
  task :start do;end

  task :stop do;end

  desc "Restart Production Server"
  task :restart do
    run 'appctl restart production'
  end

  task :environment do
    run "cd #{current_path}; cp #{shared_path}/.environment ."
  end
end

after 'deploy:migrate', 'deploy:environment'
after 'deploy:create_symlink', 'deploy:cleanup' 
before 'deploy:restart', 'deploy:migrate'
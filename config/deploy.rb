set :application, "5slices.com"
set :runner, "avk"
set :user, "avk"
set :use_sudo, true

# set :deploy_via, :slipstream_remote_cache
# set :release_subdirectory, 'railsapp'
set :deploy_to, "/home/#{user}/public_html/#{application}"

set :scm, :git
set :repository, "git@github.com:avk/5slices.git"
set :branch, ENV["BRANCH"] || "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:port] = 8888

role :app, application
role :web, application
role :db, application, :primary => true



after "deploy:setup", "chown"

desc "changes the owner of the root directory"
task :chown do
  run "sudo chown -R #{runner} #{deploy_to}"
end

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do
  end
  task :stop do
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

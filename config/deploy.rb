set :application, "maverick"
set :scm, "git"
set :repository,  "git@github.com:mza/#{application}.git"
set :branch, "master"
set :user, "root"
set :deploy_to, "/var/rails/#{application}"
set :scm_verbose, true

ssh_options[:forward_agent] = true
ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/id_rsa-gsg-keypair"]
default_run_options[:pty] = true

role :app, "injectify.com"
role :web, "injectify.com"
role :db,  "injectify.com", :primary => true

after :deploy, "set_ownership"

namespace :deploy do
  
  desc "Correctly sets ownership of environment.rb"  
  task :set_ownership do
    run "chown www-data:www-data #{current_path}/config/environment.rb"
  end
  
  desc "Restarting Passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is unnecessary with Passenger"
    task t, :roles => :app do ; end
  end
end
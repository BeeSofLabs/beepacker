## Digital Ocean
server "128.199.98.84",
  user: 'deployer',
  roles: %w{app web db},
  primary: false,
  password: 'P@$$w0rd01'

  
role :app,  %w{deployer@128.199.98.84}
role :web,  %w{deployer@128.199.98.84}
role :db,   %w{deployer@128.199.98.84}

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deployer/beepacker' #'/var/www/ombre'

set :tmp_dir, "/home/deployer/beepacker"
set :branch, 'master'
set :rails_env, :production

# Attention: enable this if there is changes on cronjob
# set :whenever_command, 'cd /home/deployer/ombre/current && RAILS_ENV=production bundle exec whenever -w'
# set :whenever_command, 'cd /home/deployer/ombre/current && RAILS_ENV=production bundle exec whenever'

namespace :cron do
  task :execute do
    on roles :app do
      execute 'cd /home/deployer/beepacker/current && RAILS_ENV=production bundle exec whenever -w'
      execute 'cd /home/deployer/beepacker/current && RAILS_ENV=production bundle exec whenever'
    end
  end
end

namespace :server do
  task :unicorn_start do
    on roles :app do
      execute "touch /home/deployer/beepacker/unicorn.pid"
      execute "/etc/init.d/unicorn_beepacker stop"
      execute "/etc/init.d/unicorn_beepacker restart"
    end
  end
  
  task :unicorn_stop do
    on roles :app do
      execute "/etc/init.d/unicorn_beepacker stop"
    end
  end
  
  
  task :sidekiq_start do
    on roles :app do
      execute "cd /home/deployer/ombre/current && RAILS_ENV=production bundle exec sidekiq -d -L log/sidekiq_job.log"
    end
  end
  
  task :sidekiq_stop do
    on roles :app do
      execute "cd /home/deployer/ombre/current && ps axf | grep sidekiq | grep -v grep | awk '{print \"kill -9 \" $1}' | sh"
    end
  end  
end


# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }




# This is where the actual deployment with Unicorn happens.
# namespace :deploy do
#   desc "Start the Unicorn process when it isn't already executening."
#   task :start do
#     execute "cd #{current_path} && #{current_path}/bin/unicorn -Dc #{shared_path}/config/unicorn.rb -E production"
#   end
# 
#   desc "Initiate a rolling restart by telling Unicorn to start the new application code and kill the old process when done."
#   task :restart do
#     execute "kill -USR2 $(cat #{shared_path}/pids/unicorn.pid)"
#   end
# 
#   desc "Stop the application by killing the Unicorn process"
#   task :stop do
#     execute "kill $(cat #{shared_path}/pids/unicorn.pid)"
#   end
# end

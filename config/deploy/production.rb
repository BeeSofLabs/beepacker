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
set :deploy_to, '/home/deployer' #'/var/www/beepacker'

set :tmp_dir, "/home/deployer"
set :branch, 'master'
set :rails_env, :production

# Attention: enable this if there is changes on cronjob
# set :whenever_command, 'cd /home/deployer/beepacker/current && RAILS_ENV=production bundle exec whenever -w'
# set :whenever_command, 'cd /home/deployer/beepacker/current && RAILS_ENV=production bundle exec whenever'

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
      execute "cd /home/deployer/beepacker/current && RAILS_ENV=production bundle exec sidekiq -d -L log/sidekiq_job.log"
    end
  end
  
  task :sidekiq_stop do
    on roles :app do
      execute "cd /home/deployer/beepacker/current && ps axf | grep sidekiq | grep -v grep | awk '{print \"kill -9 \" $1}' | sh"
    end
  end  
end
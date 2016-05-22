root  = "/home/deployer/ombre"
app   = "#{root}/current" 

pid           "#{root}/unicorn.pid"
stderr_path   "#{app}/log/unicorn.log"
stdout_path   "#{app}/log/unicorn.log"

# listen "/tmp/unicorn.gigmit.com.socket", :backlog => 2048
listen "0.0.0.0:4000"

# preload_app true
working_directory app
worker_processes 3
timeout 15

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end  
  
after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
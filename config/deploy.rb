# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'beepacker'
# set :repo_url, 'https://github.com/vltlabs/ombre.git'
set :repo_url, 'git@github.com:vltlabs/ombre.git'
set :user, 'deployer'

set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa_digitalocean.pub) }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp


# Default value for :scm is :git
set :scm, :git
set :deploy_via, :remote_cache # git pull instead of git clone upon every deploy

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# custom rvm roles
set :rvm_roles, [:app, :web]


# Default value for :linked_files is []
set :linked_dirs, [] #fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :linked_files, [] #fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

set :bundle_flags, ''


source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
gem 'rack-cors', require: 'rack/cors'
gem 'therubyracer'

# db-server
gem 'pg', '0.18.2'

# file upload
gem 'paperclip', '~> 4.3'
# gem 'aws-sdk', '~> 1.5.7'

# backend editing
# gem 'rails_admin', :path => "~/myfolder/development/labs/rails_admin"
gem 'rails_admin', :git => "https://github.com/acan12/rails_admin.git"

gem 'ckeditor'

# authentication
gem 'bcrypt', '~> 3.1.7'

#Mobile APP api
gem 'active_model_serializers'
gem 'enumerize'



# gem 'friendly_id'
# gem 'acts-as-taggable-on', '~> 3.4'
# gem 'mandrill-api' # Interface to Mandrill for sending emails and email management
# gem 'parse-ruby-client'
# gem "acts_as_follower", :path => "vendor/acts_as_follower_fork"

# front end
gem "slim-rails"
gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '>= 3.2'
gem 'uglifier', '>= 1.3.0'


# server
gem 'unicorn'
gem 'unicorn-worker-killer'

# pagination
gem 'kaminari'


# cache
# gem 'redis'
# gem 'redis-namespace'
# gem 'redis-rails'
# gem 'redis-rack-cache'

# background job
gem 'sinatra', :require => nil
gem 'sidekiq'

# cron job
# gem 'whenever', require: false

# gcm push notification
gem 'gcm'


group :development do
  gem 'annotate'
  gem 'heroku_san'
  gem 'auto_tagger'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'launchy'
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'seed_dump'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'
  # gem 'capistrano3-unicorn'
  gem 'sepastian-capistrano3-unicorn', :require => false
  gem 'capistrano-rails-db'
end

group :development, :test do
  gem 'byebug'
  gem 'faker', ' ~> 1.5.0'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '4.2.0'
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'pry'
  gem 'skylight'
  gem 'rack-mini-profiler'
end

group :test do
  gem 'spring-commands-rspec'
  gem 'codeclimate-test-reporter', require: nil
  gem 'simplecov', '~> 0.7.1'
  gem 'poltergeist'
  gem 'capybara'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'shoulda-matchers'
end

group :production, :staging do
  # gem 'heroku-deflater'
  gem 'rails_12factor'
  gem 'sendgrid'
end

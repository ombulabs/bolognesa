source 'http://rubygems.org'

ruby '2.1.0'

gem 'rails', '3.2.18'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass', '~> 3.2.13'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails'
  gem 'compass-rails'
  gem 'compass'
  gem 'uglifier'
end

gem 'jquery-rails'

gem 'rb-readline'

# Using Omniauth-Github for Github login
gem 'omniauth-github'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem 'capybara', git: 'git@github.com:jnicklas/capybara.git'
  gem 'rspec-rails', '~> 2.14.1'
  gem 'rspec-core', '~> 2.14.7'
  gem 'database_cleaner'
  gem 'selenium-webdriver', '~> 2.39.0'
end

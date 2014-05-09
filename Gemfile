source 'http://rubygems.org'

ruby '2.1.0'

gem 'rails', '3.2.18'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

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

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end

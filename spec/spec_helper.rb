ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

OmniAuth.config.test_mode = true
omniauth_hash = { 'provider' => 'github',
                  'uid' => '123456',
                  'info' => {
                      'name' => 'Test McTest',
                      'email' => 'test@github.com',
                      'nickname' => 'github-test'
                  },
                  'extra' => {'raw_info' =>
                                  { 'location' => 'Argentina',
                                    'gravatar_id' => '12345678'
                                  }
                  }
}
OmniAuth.config.add_mock(:github, omniauth_hash)

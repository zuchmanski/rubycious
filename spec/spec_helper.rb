# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
# require 'capybara/rails'
require 'capybara/rspec'
require 'webmock/rspec'
require Rails.root.join("spec/factories.rb")

OmniAuth.config.test_mode = true

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({:provider => 'github', :uid => '1'})

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.use_transactional_fixtures = false

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

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def sign_in_admin
  admin = FactoryGirl.create(:user, :admin => true, :uid => 1)
  visit '/'
  click_link "log in via github"
end

def sign_in_user
  user = FactoryGirl.create(:user, :uid => 1)
  visit '/'
  click_link "log in via github"
end
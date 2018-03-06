require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require_relative './helpers'
require_relative './params_factory'
require_relative './factory_boyfriend'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include ::RailsEventStore::RSpec::Matchers
  config.include Helpers
  config.include ParamsFactory
  config.include FactoryBoyfriend

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE questions_cursor_seq RESTART WITH 1")

    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

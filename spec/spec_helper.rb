# frozen_string_literal: true

require 'bundler/setup'
require 'csv_converter'
require 'byebug'

Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include CSVConverter::Helpers
  config.extend  CSVConverter::Helpers

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

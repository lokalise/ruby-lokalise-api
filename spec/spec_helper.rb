# frozen_string_literal: true

require 'dotenv/load'
require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter '.github/'
end

if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'ruby-lokalise-api'

# Support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include TestClient
end

require 'dotenv/load'
require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter '.github/'
end

require 'ruby-lokalise-api'

# Support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include TestClient
end

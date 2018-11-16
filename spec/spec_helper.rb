require 'simplecov'
SimpleCov.start

require 'ruby-lokalise-api'

# Support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include TestClient
end
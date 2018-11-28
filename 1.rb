require_relative 'lib/ruby-lokalise-api'
require 'dotenv/load'

@client = Lokalise.client ENV['LOKALISE_API_TOKEN']

puts @client.language('803826145ba90b42d5d860.46800099', '640').inspect

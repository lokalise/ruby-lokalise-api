require_relative 'lib/ruby-lokalise-api'
require 'dotenv/load'

@client = Lokalise.client ENV['LOKALISE_API_TOKEN']

puts @client.teams.inspect

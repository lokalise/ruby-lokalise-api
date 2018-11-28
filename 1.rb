require 'dotenv/load'

lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-lokalise-api'


@client = Lokalise.client ENV['LOKALISE_API_TOKEN']

puts @client.teams.inspect

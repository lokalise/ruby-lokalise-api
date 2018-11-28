require_relative 'lib/ruby-lokalise-api'
require 'dotenv/load'

@client = Lokalise.client ENV['LOKALISE_API_TOKEN']

puts  @client.project_languages('803826145ba90b42d5d860.46800099').inspect
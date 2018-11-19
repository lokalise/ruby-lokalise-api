require_relative 'lib/ruby-lokalise-api'
require 'dotenv/load'

@client = Lokalise.client ENV['LOKALISE_API_TOKEN']
#puts @client.inspect
project = @client.delete_project '873947295bf2dc4f613d72.52698259'

puts project.inspect
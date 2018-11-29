require 'dotenv/load'

lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-lokalise-api'

@client = Lokalise.client ENV['LOKALISE_API_TOKEN']

# puts @client.create_key_comment('803826145ba90b42d5d860.46800099', '13207975',
# {comment: 'test'}).inspect

puts @client.delete_comment('803826145ba90b42d5d860.46800099',
                            '13207975', '767008').inspect

# puts @client.keys('803826145ba90b42d5d860.46800099').inspect

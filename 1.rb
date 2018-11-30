require 'base64'
require 'dotenv/load'

lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-lokalise-api'

@client = Lokalise.client ENV['LOKALISE_API_TOKEN']

# puts @client.create_key_comment('803826145ba90b42d5d860.46800099', '13207975',
# {comment: 'test'}).inspect

puts @client.update_translation('672198945b7d72fc048021.15940510', '60116676',
                                translation: 'tester',
                                is_fuzzy: false).inspect

# puts @client.keys('803826145ba90b42d5d860.46800099').inspect

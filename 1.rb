require 'base64'
require 'dotenv/load'

lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-lokalise-api'

@client = Lokalise.client ENV['LOKALISE_API_TOKEN']

# puts @client.create_key_comment('803826145ba90b42d5d860.46800099', '13207975',
# {comment: 'test'}).inspect
puts @client.delete_task('803826145ba90b42d5d860.46800099', '4053').inspect

# puts @client.create_task('803826145ba90b42d5d860.46800099',
#                          {
#                            title: 'demo',
#                            keys: ['13207975'],
#                            languages: [
#                              {
#                                language_iso: 'ru',
#                                users: ['20181']
#                              }
#                            ]
#                          }).inspect

# puts @client.keys('803826145ba90b42d5d860.46800099').inspect

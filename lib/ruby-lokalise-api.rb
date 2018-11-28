require 'faraday'
require 'multi_json'

require 'ruby-lokalise-api/version'
require 'ruby-lokalise-api/connection'
require 'ruby-lokalise-api/request'
require 'ruby-lokalise-api/error'

require 'ruby-lokalise-api/resources/base'
require 'ruby-lokalise-api/resources/project'
require 'ruby-lokalise-api/resources/project_language'

require 'ruby-lokalise-api/collections/base'
require 'ruby-lokalise-api/collections/project'
require 'ruby-lokalise-api/collections/team'
require 'ruby-lokalise-api/collections/system_language'
require 'ruby-lokalise-api/collections/project_language'

require 'ruby-lokalise-api/client'

module Lokalise
  # Initializes a new Client object
  #
  # @return [Lokalise::Client]
  def self.client(token)
    @client ||= Lokalise::Client.new token
  end
end

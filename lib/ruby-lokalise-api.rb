require 'faraday'
require 'multi_json'

require_relative 'ruby-lokalise-api/version'
require_relative 'ruby-lokalise-api/connection'
require_relative 'ruby-lokalise-api/request'
require_relative 'ruby-lokalise-api/error'

require_relative 'ruby-lokalise-api/resources/base'
require_relative 'ruby-lokalise-api/resources/project'
require_relative 'ruby-lokalise-api/resources/project_language'

require_relative 'ruby-lokalise-api/collections/base'
require_relative 'ruby-lokalise-api/collections/project'
require_relative 'ruby-lokalise-api/collections/system_language'
require_relative 'ruby-lokalise-api/collections/project_language'

require_relative 'ruby-lokalise-api/client'

module Lokalise
  # Initializes a new Client object
  #
  # @return [Lokalise::Client]
  def self.client(token)
    @client ||= Lokalise::Client.new token
  end
end

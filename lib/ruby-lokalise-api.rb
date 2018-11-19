require 'faraday'
require 'multi_json'

require 'ruby-lokalise-api/version'
require 'ruby-lokalise-api/connection'
require 'ruby-lokalise-api/request'
require 'ruby-lokalise-api/error'
require 'ruby-lokalise-api/client'

module Lokalise
  # Initializes a new Client object
  #
  # @return [Lokalise::Client]
  def self.client(token)
    @client ||= Lokalise::Client.new token
  end
end
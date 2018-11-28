require 'ruby-lokalise-api/rest/languages'
require 'ruby-lokalise-api/rest/teams'
require 'ruby-lokalise-api/rest/projects'

module Lokalise
  class Client
    attr_reader :token

    def initialize(token)
      @token = token
    end
  end
end

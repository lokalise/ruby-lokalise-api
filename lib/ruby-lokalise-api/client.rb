require 'ruby-lokalise-api/rest/languages'
require 'ruby-lokalise-api/rest/teams'
require 'ruby-lokalise-api/rest/projects'
require 'ruby-lokalise-api/rest/comments'
require 'ruby-lokalise-api/rest/keys'
require 'ruby-lokalise-api/rest/contributors'
require 'ruby-lokalise-api/rest/files'

module Lokalise
  class Client
    attr_reader :token

    def initialize(token)
      @token = token
    end
  end
end

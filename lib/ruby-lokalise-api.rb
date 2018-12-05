require 'faraday'
require 'multi_json'
require 'yaml'
require 'pry'

require 'ruby-lokalise-api/version'
require 'ruby-lokalise-api/connection'
require 'ruby-lokalise-api/request'
require 'ruby-lokalise-api/error'
require 'ruby-lokalise-api/utils/string_utils'
require 'ruby-lokalise-api/utils/attributes'

require 'ruby-lokalise-api/resources/base'
require 'ruby-lokalise-api/resources/project'
require 'ruby-lokalise-api/resources/project_language'
require 'ruby-lokalise-api/resources/key_comment'
require 'ruby-lokalise-api/resources/contributor'
require 'ruby-lokalise-api/resources/file'
require 'ruby-lokalise-api/resources/translation'
require 'ruby-lokalise-api/resources/team_user'
require 'ruby-lokalise-api/resources/task'
require 'ruby-lokalise-api/resources/snapshot'
require 'ruby-lokalise-api/resources/screenshot'
require 'ruby-lokalise-api/resources/key'
require 'ruby-lokalise-api/resources/project_comment'

require 'ruby-lokalise-api/collections/base'
require 'ruby-lokalise-api/collections/project'
require 'ruby-lokalise-api/collections/team'
require 'ruby-lokalise-api/collections/system_language'
require 'ruby-lokalise-api/collections/project_language'
require 'ruby-lokalise-api/collections/project_comment'
require 'ruby-lokalise-api/collections/key_comment'
require 'ruby-lokalise-api/collections/key'
require 'ruby-lokalise-api/collections/contributor'
require 'ruby-lokalise-api/collections/file'
require 'ruby-lokalise-api/collections/translation'
require 'ruby-lokalise-api/collections/team_user'
require 'ruby-lokalise-api/collections/task'
require 'ruby-lokalise-api/collections/snapshot'
require 'ruby-lokalise-api/collections/screenshot'

require 'ruby-lokalise-api/client'

module Lokalise
  class << self
    # Initializes a new Client object
    #
    # @return [Lokalise::Client]
    def client(token)
      @client ||= Lokalise::Client.new token
    end
  end
end

require 'ruby-lokalise-api/rest/languages'
require 'ruby-lokalise-api/rest/teams'
require 'ruby-lokalise-api/rest/projects'
require 'ruby-lokalise-api/rest/comments'
require 'ruby-lokalise-api/rest/keys'
require 'ruby-lokalise-api/rest/contributors'
require 'ruby-lokalise-api/rest/files'
require 'ruby-lokalise-api/rest/translations'
require 'ruby-lokalise-api/rest/team_users'
require 'ruby-lokalise-api/rest/tasks'
require 'ruby-lokalise-api/rest/snapshots'
require 'ruby-lokalise-api/rest/screenshots'

module Lokalise
  class Client
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def construct_request(klass, method, endpoint_ids, params = {}, object_key = nil)
      path = klass.endpoint(*endpoint_ids)
      klass.send method, self, path, format_params(params, object_key)
    end

    # Converts `params` to hash with arrays under the `object_key` key.
    # Used in bulk operations
    #
    # @return [Hash]
    def format_params(params, object_key)
      return params unless object_key

      params = [params] unless params.is_a?(Array)
      Hash[object_key, params]
    end

    alias c_r construct_request
  end
end

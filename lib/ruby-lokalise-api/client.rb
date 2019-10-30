require 'ruby-lokalise-api/rest/branches'
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
require 'ruby-lokalise-api/rest/orders'
require 'ruby-lokalise-api/rest/payment_cards'
require 'ruby-lokalise-api/rest/translation_providers'
require 'ruby-lokalise-api/rest/team_user_group'
require 'ruby-lokalise-api/rest/custom_translation_statuses'
require 'ruby-lokalise-api/rest/webhooks'

module Lokalise
  class Client
    attr_reader :token
    attr_accessor :timeout, :open_timeout

    def initialize(token, params = {})
      @token = token
      @timeout = params.fetch(:timeout) { nil }
      @open_timeout = params.fetch(:open_timeout) { nil }
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

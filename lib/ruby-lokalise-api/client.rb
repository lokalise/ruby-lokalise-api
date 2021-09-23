# frozen_string_literal: true

require 'ruby-lokalise-api/rest/branches'
require 'ruby-lokalise-api/rest/languages'
require 'ruby-lokalise-api/rest/teams'
require 'ruby-lokalise-api/rest/projects'
require 'ruby-lokalise-api/rest/queued_processes'
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
    attr_reader :token, :token_header
    attr_accessor :timeout, :open_timeout, :enable_compression

    def initialize(token, params = {})
      @token = token
      @timeout = params.fetch(:timeout, nil)
      @open_timeout = params.fetch(:open_timeout, nil)
      @enable_compression = params.fetch(:enable_compression, false)
      @token_header = 'x-api-token'
    end

    # rubocop:disable Metrics/ParameterLists
    # Constructs request to perform the specified action
    # @param klass The actual class to call the method upon
    # @param method [Symbol] The method to call (:new, :update, :create etc)
    # @param endpoint_ids [Array, Hash] IDs that are used to generate the proper path to the endpoint
    # @param params [Array, Hash] Request parameters
    # @param object_key [String, Symbol] Key that should be used to wrap parameters into
    # @param initial_ids [Array] IDs that should be used to generate base endpoint path. The base path is used for method chaining
    def construct_request(klass, method, endpoint_ids, params = {}, object_key = nil, initial_ids = nil)
      path = klass.endpoint(*endpoint_ids)
      formatted_params = format_params(params, object_key)
      formatted_params[:_initial_path] = klass.endpoint(*initial_ids) if initial_ids
      klass.send method, self, path, formatted_params
    end
    # rubocop:enable Metrics/ParameterLists

    # Converts `params` to hash with arrays under the `object_key` key.
    # Used in bulk operations
    #
    # @return [Hash]
    def format_params(params, object_key)
      return params unless object_key

      params = [params] unless params.is_a?(Array)
      {object_key => params}
    end

    alias c_r construct_request
  end
end

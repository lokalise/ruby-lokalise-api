# frozen_string_literal: true

module RubyLokaliseApi
  class BaseClient
    attr_reader :token, :token_header
    attr_accessor :timeout, :open_timeout

    def initialize(token, params = {})
      @token = token
      @timeout = params.fetch(:timeout, nil)
      @open_timeout = params.fetch(:open_timeout, nil)
      @token_header = ''
    end

    # rubocop:disable Metrics/ParameterLists
    # Constructs request to perform the specified action
    # @param klass The actual class to call the method upon
    # @param method [Symbol] The method to call (:new, :update, :create etc)
    # @param endpoint_ids [Array, Hash] IDs that are used to generate the proper path to the endpoint
    # @param params [Array, Hash] Request parameters
    # @param object_key [String, Symbol] Key that should be used to wrap parameters into
    # @param initial_ids [Array] IDs that should be used to generate base endpoint path.
    # The base path is used for method chaining
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

    def base_url; end

    def compression?; end

    alias c_r construct_request
  end
end

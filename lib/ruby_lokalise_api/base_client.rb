# frozen_string_literal: true

module RubyLokaliseApi
  # This class contains the base client. Inherited by Client (regular API client)
  # and OAuth2Client (used for OAuth2-based authentication)
  class BaseClient
    include RubyLokaliseApi::Rest

    attr_reader :token, :token_header, :api_host
    attr_accessor :timeout, :open_timeout

    def initialize(token, params = {})
      @token = token
      @timeout = params.fetch(:timeout, nil)
      @open_timeout = params.fetch(:open_timeout, nil)
      @token_header = ''
      @api_host = params.fetch(:api_host, nil)
    end
  end
end

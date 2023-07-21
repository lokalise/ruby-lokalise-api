# frozen_string_literal: true

module RubyLokaliseApi
  # Regular API client used to perform requests with a basic API token
  class Client < BaseClient
    def initialize(token, params = {})
      super(token, params)

      @token_header = 'x-api-token'
    end
  end
end

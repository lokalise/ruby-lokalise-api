# frozen_string_literal: true

module RubyLokaliseApi
  # Regular API client used to perform requests with a basic API token
  class Client < BaseClient
    include RubyLokaliseApi::Rest

    def initialize(token, params = {})
      super(token, params)

      @token_header = 'x-api-token'
    end
  end
end

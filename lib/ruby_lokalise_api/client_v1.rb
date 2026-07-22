# frozen_string_literal: true

module RubyLokaliseApi
  # API client used to perform requests against new Lokalise API v1
  class ClientV1 < BaseClient
    include RubyLokaliseApi::RestV1

    def initialize(token, params = {})
      super

      @token_header = 'x-api-token'
    end
  end
end

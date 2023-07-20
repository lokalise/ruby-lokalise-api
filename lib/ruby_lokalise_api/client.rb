# frozen_string_literal: true

module RubyLokaliseApi
  class Client < BaseClient
    include RubyLokaliseApi::Rest

    def initialize(token, params = {})
      super(token, params)

      @token_header = 'x-api-token'
    end
  end
end

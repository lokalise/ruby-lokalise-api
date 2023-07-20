# frozen_string_literal: true

module RubyLokaliseApi
  class OAuth2Client < Client
    include RubyLokaliseApi::Rest

    def initialize(token, params = {})
      super(token, params)
      @token_header = 'Authorization'
      @token = "Bearer #{@token}"
    end
  end
end

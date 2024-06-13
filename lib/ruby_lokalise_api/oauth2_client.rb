# frozen_string_literal: true

module RubyLokaliseApi
  # Client used to perform API requests with an OAuth2 access token
  class OAuth2Client < Client
    def initialize(token, params = {})
      super
      @token_header = 'Authorization'
      @token = "Bearer #{@token}"
    end
  end
end

# frozen_string_literal: true

module RubyLokaliseApi
  module OAuth2
    class Token
      attr_reader :access_token, :refresh_token, :expires_in, :token_type

      def initialize(raw_params)
        @access_token = raw_params['access_token']
        @refresh_token = raw_params['refresh_token']
        @expires_in = raw_params['expires_in']
        @token_type = raw_params['token_type']
      end
    end
  end
end

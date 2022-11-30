# frozen_string_literal: true

module RubyLokaliseApi
  module OAuth2
    class Refresh
      attr_reader :access_token, :expires_in, :scope, :token_type

      def initialize(raw_params)
        @access_token = raw_params['access_token']
        @expires_in = raw_params['expires_in']
        @scope = raw_params['scope']
        @token_type = raw_params['token_type']
      end
    end
  end
end

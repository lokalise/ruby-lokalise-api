# frozen_string_literal: true

module RubyLokaliseApi
  module OAuth2
    # This class defines OAuth2 flow
    class Auth
      attr_reader :client_id, :client_secret, :timeout, :open_timeout, :api_host

      OAUTH2_ENDPOINT = RubyLokaliseApi::Endpoints::OAuth2::OAuth2Endpoint

      def initialize(client_id, client_secret, params = {})
        @client_id = client_id
        @client_secret = client_secret
        @timeout = params[:timeout]
        @open_timeout = params[:open_timeout]
        @api_host = params[:api_host]
      end

      # Returns OAuth2 endpoint URI
      def oauth2_endpoint
        self.class.const_get(:OAUTH2_ENDPOINT)
      end

      # Builds an OAuth2 link that customers have to visit
      # in order to obtain a special code
      # @return [String]
      # @param scope [Array, String]
      # @param redirect_uri [String]
      # @param state [String]
      def auth(scope:, redirect_uri: nil, state: nil)
        get_params = {
          client_id: client_id,
          scope: scope_to_string(scope),
          state: state,
          redirect_uri: redirect_uri
        }

        oauth2_endpoint.new(self, query: 'auth', get: get_params).full_uri
      end

      # Requests an OAuth2 access token using a code
      # @param code [String] The authorization code
      # @return [RubyLokaliseApi::Resources::OAuth2Token] The OAuth2 token resource
      def token(code)
        request_token(grant_type: 'authorization_code', code: code)
      end

      # Refreshes an expired OAuth2 token
      # @param refresh_token [String] The refresh token
      # @return [RubyLokaliseApi::Resources::OAuth2RefreshedToken] The refreshed token resource
      def refresh(refresh_token)
        request_token(grant_type: 'refresh_token', refresh_token: refresh_token)
      end

      private

      # Generalized method for requesting a token
      # @param params [Hash] Request parameters including grant type
      # @return [RubyLokaliseApi::Resources::OAuth2Token, RubyLokaliseApi::Resources::OAuth2RefreshedToken]
      def request_token(params)
        endpoint = oauth2_endpoint.new(self, query: :token, req: common_params.merge(params))
        resource_class = if params[:grant_type] == 'authorization_code'
                           RubyLokaliseApi::Resources::OAuth2Token
                         else
                           RubyLokaliseApi::Resources::OAuth2RefreshedToken
                         end
        resource_class.new(endpoint.do_post)
      end

      # Converts scope to a space-separated string if it's an array
      # @param scope [Array, String] The scope or scopes
      # @return [String] The scope as a string
      def scope_to_string(scope)
        scope.is_a?(Array) ? scope.join(' ') : scope
      end

      def common_params
        {
          client_id: @client_id,
          client_secret: @client_secret
        }
      end
    end
  end
end

# frozen_string_literal: true

module RubyLokaliseApi
  module OAuth2
    # This class defines OAuth2 flow
    class Auth
      attr_reader :client_id, :client_secret, :timeout, :open_timeout

      OAUTH2_ENDPOINT = RubyLokaliseApi::Endpoints::OAuth2::OAuth2Endpoint

      def initialize(client_id, client_secret, params = {})
        @client_id = client_id
        @client_secret = client_secret
        @timeout = params[:timeout]
        @open_timeout = params[:open_timeout]
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
          scope: (scope.is_a?(Array) ? scope.join(' ') : scope),
          state: state,
          redirect_uri: redirect_uri
        }

        oauth2_endpoint.new(self, query: 'auth', get: get_params).full_uri
      end

      # Requests OAuth2 access token. Requires OAuth2 code obtained
      # using the `.auth` method
      # @return [RubyLokaliseApi::Resources::OAuth2Token]
      # @param code [String]
      def token(code)
        endpoint = oauth2_endpoint.new(
          self,
          query: :token,
          req: common_params.merge(
            grant_type: 'authorization_code',
            code: code
          )
        )

        RubyLokaliseApi::Resources::OAuth2Token.new endpoint.do_post
      end

      # Refreshes expired OAuth2 access token.
      # @return [RubyLokaliseApi::Resources::OAuth2RefreshedToken]
      # @param refresh_token [String]
      def refresh(refresh_token)
        endpoint = oauth2_endpoint.new(
          self,
          query: :token,
          req: common_params.merge(
            grant_type: 'refresh_token',
            refresh_token: refresh_token
          )
        )

        RubyLokaliseApi::Resources::OAuth2RefreshedToken.new endpoint.do_post
      end

      private

      def common_params
        {
          client_id: @client_id,
          client_secret: @client_secret
        }
      end
    end
  end
end

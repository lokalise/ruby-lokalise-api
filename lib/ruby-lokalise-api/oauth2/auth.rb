# frozen_string_literal: true

module Lokalise
  module OAuth2
    class Auth
      include Lokalise::OAuth2::Request

      attr_reader :client_id, :client_secret

      def initialize(client_id, client_secret)
        @client_id = client_id
        @client_secret = client_secret
      end

      def auth(scope:, redirect_uri: nil, state: nil)
        scope = scope.join(' ') if scope.is_a?(Array)

        params = {
          client_id: client_id,
          scope: scope
        }
        params[:state] = state unless state.nil?
        params[:redirect_uri] = redirect_uri unless redirect_uri.nil?

        _build_url_from params
      end

      def token(code)
        params = base_params.merge({
                                     code: code,
                                     grant_type: 'authorization_code'
                                   })
        post 'token', params
      end

      def refresh(token)
        params = base_params.merge({
                                     refresh_token: token,
                                     grant_type: 'refresh_token'
                                   })
        post 'token', params
      end

      private

      def base_params
        {
          client_id: client_id,
          client_secret: client_secret
        }
      end

      def _build_url_from(params)
        URI::HTTPS.build(
          host: BASE_URL.host,
          path: "#{BASE_URL.path}auth",
          query: URI.encode_www_form(params)
        ).to_s
      end
    end
  end
end

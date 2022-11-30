# frozen_string_literal: true

module RubyLokaliseApi
  module OAuth2
    class Auth
      include RubyLokaliseApi::BaseRequest

      attr_reader :client_id, :client_secret, :timeout, :open_timeout

      def initialize(client_id, client_secret, params = {})
        @client_id = client_id
        @client_secret = client_secret
        @timeout = params[:timeout]
        @open_timeout = params[:open_timeout]
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

        RubyLokaliseApi::OAuth2::Token.new post('token', self, params)
      end

      def refresh(token)
        params = base_params.merge({
                                     refresh_token: token,
                                     grant_type: 'refresh_token'
                                   })

        RubyLokaliseApi::OAuth2::Refresh.new post('token', self, params)
      end

      def base_url
        URI('https://app.lokalise.com/oauth2/')
      end

      def compression?
        false
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
          host: base_url.host,
          path: "#{base_url.path}auth",
          query: URI.encode_www_form(params)
        ).to_s
      end
    end
  end
end

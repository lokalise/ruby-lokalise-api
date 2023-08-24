# frozen_string_literal: true

module RubyLokaliseApi
  # Module to setup connection using Faraday
  module Connection
    # Creates a new Faraday object with specified params
    def connection(endpoint, params = {})
      Faraday.new(options(endpoint, params), request_params_for(endpoint.client)) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.request(:gzip)
      end
    end

    private

    def options(endpoint, params)
      req_params = __base_options(endpoint)
      client = endpoint.client

      if client.respond_to?(:token) && client.respond_to?(:token_header)
        req_params[:headers][client.token_header] = client.token
      end

      # Sending content-type is needed only when the body is actually present
      # Trying to send this header in other cases seems to result in error 500
      req_params[:headers]['Content-type'] = 'application/json' if !params[:get_request] && endpoint.req_params

      req_params[:headers][:accept_encoding] = 'gzip,deflate,br'

      req_params
    end

    def __base_options(endpoint)
      {
        headers: {
          accept: 'application/json',
          user_agent: "ruby-lokalise-api gem/#{RubyLokaliseApi::VERSION}"
        },
        url: endpoint.base_url
      }
    end

    # Allows to customize request params per-client
    def request_params_for(client)
      {
        request: {
          timeout: client.timeout,
          open_timeout: client.open_timeout
        }
      }
    end
  end
end

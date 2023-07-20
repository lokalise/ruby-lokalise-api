# frozen_string_literal: true

module RubyLokaliseApi
  module Connection
    def connection(endpoint)
      Faraday.new(options(endpoint), request_params_for(endpoint.client)) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.request(:gzip)
      end
    end

    private

    def options(endpoint)
      params = __base_options(endpoint)
      client = endpoint.client

      if client.respond_to?(:token) && client.respond_to?(:token_header)
        params[:headers][client.token_header] = client.token
      end
      params[:headers][:accept_encoding] = 'gzip,deflate,br'

      params
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

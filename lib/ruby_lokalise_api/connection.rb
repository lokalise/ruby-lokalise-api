# frozen_string_literal: true

module RubyLokaliseApi
  module Connection
    def connection(client)
      Faraday.new(options(client), request_params_for(client)) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.request(:gzip) if client.compression?
      end
    end

    private

    def options(client)
      params = __base_options(client)

      if client.respond_to?(:token) && client.respond_to?(:token_header)
        params[:headers][client.token_header] = client.token
      end
      params[:headers][:accept_encoding] = 'gzip,deflate,br' if client.compression?

      params
    end

    def __base_options(client)
      {
        headers: {
          accept: 'application/json',
          user_agent: "ruby-lokalise-api gem/#{RubyLokaliseApi::VERSION}"
        },
        url: client.base_url
      }
    end

    # Allows to customize request params per-client
    def request_params_for(client)
      {request: {timeout: client.timeout, open_timeout: client.open_timeout}}
    end
  end
end

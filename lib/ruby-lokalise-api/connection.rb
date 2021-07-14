# frozen_string_literal: true

module Lokalise
  module Connection
    BASE_URL = 'https://api.lokalise.com/api2/'

    def connection(client)
      Faraday.new(options(client), request_params_for(client)) do |faraday|
        faraday.use(:gzip) if client.enable_compression
        faraday.adapter Faraday.default_adapter
      end
    end

    private

    def options(client)
      {
        headers: {
          accept: 'application/json',
          user_agent: "ruby-lokalise-api gem/#{Lokalise::VERSION}",
          'x-api-token': client.token
        },
        url: BASE_URL
      }
    end

    # Allows to customize request params per-client
    def request_params_for(client)
      {request: {timeout: client.timeout, open_timeout: client.open_timeout}}
    end
  end
end

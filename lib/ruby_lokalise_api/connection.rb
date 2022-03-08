# frozen_string_literal: true

module RubyLokaliseApi
  module Connection
    BASE_URL = 'https://api.lokalise.com/api2/'

    def connection(client)
      Faraday.new(options(client), request_params_for(client)) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.request :gzip
      end
    end

    private

    def options(client)
      {
        headers: {
          accept: 'application/json',
          user_agent: "ruby-lokalise-api gem/#{RubyLokaliseApi::VERSION}",
          accept_encoding: 'gzip,deflate,br',
          client.token_header => client.token
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
module Lokalise
  module Connection
    BASE_URL = 'https://api.lokalise.co/api2/'.freeze

    def connection(client)
      options = {
        headers: {
          accept: 'application/json',
          user_agent: "ruby-lokalise-api gem/#{Lokalise::VERSION}",
          'x-api-token': client.token
        },
        url: BASE_URL
      }
      Faraday.new(options, request_params_for(client)) { |faraday| faraday.adapter Faraday.default_adapter }
    end

    private

    # Allows to customize request params per-client
    def request_params_for(client)
      {request: {timeout: client.timeout, open_timeout: client.open_timeout}}
    end
  end
end

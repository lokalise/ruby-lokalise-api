module Lokalise
  module Connection
    BASE_URL = 'https://api.lokalise.co/api2/'.freeze

    def connection(token)
      options = {
        headers: {
          accept: 'application/json',
          user_agent: "ruby-lokalise-api gem/#{Lokalise::VERSION}",
          'x-api-token': token
        },
        url: BASE_URL
      }
      Faraday.new(options) { |faraday| faraday.adapter Faraday.default_adapter }
    end
  end
end

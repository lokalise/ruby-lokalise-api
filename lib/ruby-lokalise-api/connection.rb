module Lokalise
  module Connection
    BASE_URL = 'https://api.lokalise.co/api2/'.freeze

    def connection(token)
      options = {
        headers: {
          accept: 'application/json',
          user_agent: "ruby-lokalise-api gem/#{Lokalise::VERSION}",
          'X-Api-Token': token
        },
        url: BASE_URL + '/'
      }

      Faraday.new options do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
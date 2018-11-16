module Lokalise
  module Connection
    # TODO: add base url
    BASE_URL = ''.freeze

    def connection
      options = {
        headers: {
          accept: 'application/json',
          user_agent: "ruby-lokalise-api gem/#{Lokalise::VERSION}"
        },
        url: BASE_URL + '/'
      }

      Faraday.new options do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
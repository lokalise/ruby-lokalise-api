module Lokalise
  module OAuth2
    module Connection
      BASE_URL = URI('https://app.lokalise.com/oauth2/')

      def connection
        Faraday.new(options) {|f| f.adapter :httpx}
      end

      private

      def options
        {
          headers: {
            accept: 'application/json',
            user_agent: "ruby-lokalise-api gem/#{Lokalise::VERSION}"
          },
          url: BASE_URL.to_s
        }
      end
    end
  end
end
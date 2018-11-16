module Lokalise
  module Request
    include Lokalise::Connection

    def get(path, params = {})
      respond perform_get(path, params)
    end

    private

    def perform_get(path, params)
      connection.get do |req|
        req.url path
        req.params = params
      end
    end

    def respond(response)
      begin
        body = MultiJson.load response.body
        # TODO: error detection
        #raise MultiJson::ParseError if body.respond_to?(:has_key?) && body.has_key?('error')
        body
      rescue MultiJson::ParseError
        respond_with_error response.status, response.body
      end
    end

    def respond_with_error(code, body)
      fail Lokalise::Error::ERRORS[code].from_response(body)
    end
  end
end
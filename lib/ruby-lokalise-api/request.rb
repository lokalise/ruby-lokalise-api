module Lokalise
  module Request
    include Lokalise::Connection

    PAGINATION_HEADERS = %w[x-pagination-total-count x-pagination-page-count x-pagination-limit x-pagination-page].freeze

    def get(path, token, params = {})
      respond connection(token).
        get(path, params)
    end

    def post(path, token, params = {})
      respond connection(token).
        post(path, MultiJson.dump(params))
    end

    def put(path, token, params = {})
      respond connection(token).
        put(path, MultiJson.dump(params))
    end

    def delete(path, token, params = {})
      respond connection(token).
        run_request(:delete, path, MultiJson.dump(params), {})
      # TODO: current version of Faraday does not allow to pass DELETE body request
      # As soon as this PR https://github.com/lostisland/faraday/issues/693 is merged,
      # replace above with:
      # delete(path, MultiJson.dump(params))
    end

    private

    def respond(response)
      body = MultiJson.load response.body
      respond_with_error(response.status, body) if body.respond_to?(:has_key?) && body.key?('error')
      response.headers.keep_if { |k, _v| PAGINATION_HEADERS.include?(k) }.merge(content: body)
    end

    def respond_with_error(code, body)
      raise(Lokalise::Error, body['error']) unless Lokalise::Error::ERRORS.key? code

      raise Lokalise::Error::ERRORS[code].from_response(body)
    end
  end
end

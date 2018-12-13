module Lokalise
  module Request
    include Lokalise::Connection

    PAGINATION_HEADERS = %w[x-pagination-total-count x-pagination-page-count x-pagination-limit x-pagination-page].freeze

    def get(path, client, params = {})
      respond_with(
        connection(client.token).get(prepare(path), params),
        client
      )
    end

    def post(path, client, params = {})
      respond_with(
        connection(client.token).post(prepare(path), MultiJson.dump(params)),
        client
      )
    end

    def put(path, client, params = {})
      respond_with(
        connection(client.token).put(prepare(path), MultiJson.dump(params)),
        client
      )
    end

    def delete(path, client, params = {})
      respond_with(
        connection(client.token).run_request(:delete, prepare(path), MultiJson.dump(params), {}),
        client
      )
      # TODO: current version of Faraday does not allow to pass DELETE body request
      # As soon as this PR https://github.com/lostisland/faraday/issues/693 is merged,
      # replace above with:
      # delete(path, MultiJson.dump(params))
    end

    private

    # Get rid of double slashes in the `path` and leading slash
    def prepare(path)
      path.gsub(%r{\A/}, '').gsub %r{//}, '/'
    end

    def respond_with(response, client)
      body = MultiJson.load response.body
      uri = Addressable::URI.parse response.env.url
      respond_with_error(response.status, body) if body.respond_to?(:has_key?) && body.key?('error')
      extract_headers_from(response).
        merge('content' => body,
              'client' => client,
              'path' => uri.path.gsub(%r{/api2/}, ''))
    end

    def extract_headers_from(response)
      response.
        headers.
        to_h.
        keep_if { |k, _v| PAGINATION_HEADERS.include?(k) }
    end

    def respond_with_error(code, body)
      raise(Lokalise::Error, body['error']) unless Lokalise::Error::ERRORS.key? code

      raise Lokalise::Error::ERRORS[code].from_response(body)
    end
  end
end

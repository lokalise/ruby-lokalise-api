# frozen_string_literal: true

module Lokalise
  module Request
    include Lokalise::Connection
    include Lokalise::JsonHandler

    # Lokalise returns pagination info in special headers
    PAGINATION_HEADERS = %w[x-pagination-total-count x-pagination-page-count x-pagination-limit x-pagination-page].freeze

    def get(path, client, params = {})
      respond_with(
        connection(client).get(prepare(path), params),
        client
      )
    end

    def post(path, client, params = {})
      respond_with(
        connection(client).post(prepare(path), custom_dump(params)),
        client
      )
    end

    def put(path, client, params = {})
      respond_with(
        connection(client).put(prepare(path), custom_dump(params)),
        client
      )
    end

    def patch(path, client, params = {})
      respond_with(
        connection(client).patch(prepare(path), params.any? ? custom_dump(params) : nil),
        client
      )
    end

    def delete(path, client, params = {})
      respond_with(
        # Rubocop tries to replace `delete` with `gsub` but that's a different method here!
        # rubocop:disable Style/CollectionMethods
        connection(client).delete(prepare(path)) do |req|
          # rubocop:enable Style/CollectionMethods
          req.body = custom_dump params
        end,
        client
      )
    end

    private

    # Get rid of double slashes in the `path`, leading and trailing slash
    def prepare(path)
      path.delete_prefix('/').gsub(%r{//}, '/').gsub(%r{/+\z}, '')
    end

    def respond_with(response, client)
      body = custom_load response.body
      uri = Addressable::URI.parse response.env.url
      status = response.status
      respond_with_error status, body if status.between?(400, 599) || (body.respond_to?(:has_key?) && body.key?('error'))
      extract_headers_from(response).
        merge('content' => body,
              'client' => client,
              'path' => uri.path.gsub(%r{/api2/}, ''))
    end

    # Get only pagination headers
    def extract_headers_from(response)
      response.
        headers.
        to_h.
        keep_if { |k, _v| PAGINATION_HEADERS.include?(k) }
    end

    def respond_with_error(code, body)
      raise(Lokalise::Error, body['error'] || body) unless Lokalise::Error::ERRORS.key? code

      raise Lokalise::Error::ERRORS[code].from_response(body)
    end
  end
end

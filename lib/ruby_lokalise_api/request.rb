# frozen_string_literal: true

module RubyLokaliseApi
  # Contains methods to perform the actual HTTP requests
  module Request
    include RubyLokaliseApi::JsonHandler
    include RubyLokaliseApi::Connection

    # Sends a GET request
    def get(endpoint)
      respond_with(
        connection(endpoint, get_request: true).get(prepare(endpoint.uri), endpoint.req_params),
        endpoint
      )
    end

    # Sends a POST request
    def post(endpoint)
      respond_with(
        connection(endpoint).post(prepare(endpoint.uri), custom_dump(endpoint.req_params)),
        endpoint
      )
    end

    # Sends a PUT request
    def put(endpoint)
      respond_with(
        connection(endpoint).put(prepare(endpoint.uri), custom_dump(endpoint.req_params)),
        endpoint
      )
    end

    # Sends a PATCH request
    def patch(endpoint)
      respond_with(
        connection(endpoint).patch(prepare(endpoint.uri),
                                   endpoint.req_params.nil? ? nil : custom_dump(endpoint.req_params)),
        endpoint
      )
    end

    # Sends a DELETE request
    def delete(endpoint)
      respond_with(
        connection(endpoint).delete(prepare(endpoint.uri)) do |req|
          req.body = custom_dump endpoint.req_params
        end,
        endpoint
      )
    end

    private

    # Get rid of double slashes in the `path`, leading and trailing slash
    def prepare(path)
      path.delete_prefix('/').gsub(%r{//}, '/').gsub(%r{/+\z}, '')
    end

    def raise_on_error!(response, body)
      return unless !response.success? || (body.respond_to?(:has_key?) && body.key?('error'))

      respond_with_error(response.status, body)
    end

    def respond_with(response, endpoint)
      begin
        body = custom_load response.body
      rescue JSON::ParserError
        respond_with_error(response.status, response.body)
      end

      raise_on_error! response, body

      RubyLokaliseApi::Response.new(body, endpoint, response.headers)
    end

    def respond_with_error(code, body)
      raise(RubyLokaliseApi::Error, body['error'] || body) unless RubyLokaliseApi::Error::ERRORS.key? code

      raise RubyLokaliseApi::Error::ERRORS[code].from_response(body)
    end
  end
end

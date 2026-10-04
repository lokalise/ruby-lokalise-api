# frozen_string_literal: true

module RubyLokaliseApi
  # Contains methods to perform the actual HTTP requests
  module Request
    include RubyLokaliseApi::JsonHandler
    include RubyLokaliseApi::Connection

    # Sends a GET request
    def get(endpoint)
      respond_with(
        connection(endpoint, get_request: true).get(normalize_path(endpoint.uri), endpoint.req_params),
        endpoint
      )
    end

    # Sends a POST request
    def post(endpoint)
      respond_with(
        connection(endpoint).post(normalize_path(endpoint.uri), request_body(endpoint)),
        endpoint
      )
    end

    # Sends a PUT request
    def put(endpoint)
      respond_with(
        connection(endpoint).put(normalize_path(endpoint.uri), request_body(endpoint)),
        endpoint
      )
    end

    # Sends a PATCH request
    def patch(endpoint)
      respond_with(
        connection(endpoint).patch(normalize_path(endpoint.uri), request_body(endpoint)),
        endpoint
      )
    end

    # Sends a DELETE request
    def delete(endpoint)
      respond_with(
        connection(endpoint).delete(normalize_path(endpoint.uri)) do |req|
          req.body = request_body(endpoint)
        end,
        endpoint
      )
    end

    private

    # Get rid of double slashes in the `path`, leading and trailing slash
    def normalize_path(path)
      path.delete_prefix('/').gsub(%r{//}, '/').gsub(%r{/+\z}, '')
    end

    def request_body(endpoint)
      return if endpoint.req_params.nil?

      custom_dump(endpoint.req_params)
    end

    def raise_on_error!(response, body)
      return unless error_response?(response, body)

      respond_with_error(response.status, body)
    end

    def error_response?(response, body)
      !response.success? || (body.respond_to?(:key?) && body.key?('error'))
    end

    def respond_with(response, endpoint)
      body = parse_response_body(response)

      raise_on_error! response, body

      RubyLokaliseApi::Response.new(body, endpoint, response.headers)
    end

    def parse_response_body(response)
      custom_load(response.body)
    rescue JSON::ParserError
      respond_with_error(response.status, response.body)
    end

    def respond_with_error(code, body)
      error_class = RubyLokaliseApi::Error::ERRORS.fetch(code, RubyLokaliseApi::Error)

      raise error_class.from_response(body)
    end
  end
end

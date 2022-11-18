# frozen_string_literal: true

module RubyLokaliseApi
  module BaseRequest
    include RubyLokaliseApi::JsonHandler
    include RubyLokaliseApi::Connection

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

    def raise_on_error!(response, body)
      return unless !response.success? || (body.respond_to?(:has_key?) && body.key?('error'))

      respond_with_error(response.status, body)
    end

    def respond_with(response, _client)
      body = custom_load response.body
      raise_on_error! response, body
      body
    end

    def respond_with_error(code, body)
      raise(RubyLokaliseApi::Error, body['error'] || body) unless RubyLokaliseApi::Error::ERRORS.key? code

      raise RubyLokaliseApi::Error::ERRORS[code].from_response(body)
    end
  end
end

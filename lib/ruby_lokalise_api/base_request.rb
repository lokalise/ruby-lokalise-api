# frozen_string_literal: true

module RubyLokaliseApi
  module BaseRequest
    include RubyLokaliseApi::JsonHandler

    private

    # Get rid of double slashes in the `path`, leading and trailing slash
    def prepare(path)
      path.delete_prefix('/').gsub(%r{//}, '/').gsub(%r{/+\z}, '')
    end

    def raise_on_error!(status, body)
      respond_with_error(status, body) if status.between?(400, 599) || (body.respond_to?(:has_key?) && body.key?('error'))
    end

    def respond_with_error(code, body)
      raise(RubyLokaliseApi::Error, body['error'] || body) unless RubyLokaliseApi::Error::ERRORS.key? code

      raise RubyLokaliseApi::Error::ERRORS[code].from_response(body)
    end
  end
end
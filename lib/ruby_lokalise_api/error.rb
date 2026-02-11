# frozen_string_literal: true

module RubyLokaliseApi
  # Standard API errors
  class Error < StandardError
    ClientError = Class.new(self)
    ServerError = Class.new(self)

    class BadRequest < ClientError
    end

    class Unauthorized < ClientError
    end

    class NotAcceptable < ClientError
    end

    class NotFound < ClientError
    end

    class Conflict < ClientError
    end

    class TooManyRequests < ClientError
    end

    class Forbidden < ClientError
    end

    class Locked < ClientError
    end

    class MethodNotAllowed < ClientError
    end

    class NotImplemented < ServerError
    end

    class BadGateway < ServerError
    end

    class ServiceUnavailable < ServerError
    end

    class GatewayTimeout < ServerError
    end

    ERRORS = {
      400 => RubyLokaliseApi::Error::BadRequest,
      401 => RubyLokaliseApi::Error::Unauthorized,
      403 => RubyLokaliseApi::Error::Forbidden,
      404 => RubyLokaliseApi::Error::NotFound,
      405 => RubyLokaliseApi::Error::MethodNotAllowed,
      406 => RubyLokaliseApi::Error::NotAcceptable,
      409 => RubyLokaliseApi::Error::Conflict,
      423 => RubyLokaliseApi::Error::Locked,
      429 => RubyLokaliseApi::Error::TooManyRequests,
      500 => RubyLokaliseApi::Error::ServerError,
      502 => RubyLokaliseApi::Error::BadGateway,
      503 => RubyLokaliseApi::Error::ServiceUnavailable,
      504 => RubyLokaliseApi::Error::GatewayTimeout
    }.freeze

    class << self
      # Create a new error from an HTTP response
      def from_response(body)
        msg = if body.respond_to?(:key)
                body.key?('error') ? body['error']['message'] : body['message']
              else
                body
              end

        new msg.to_s
      end
    end

    # Initializes a new Error object
    def initialize(message = '')
      super
    end
  end
end

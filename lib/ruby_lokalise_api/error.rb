# frozen_string_literal: true

module RubyLokaliseApi
  class Error < StandardError
    ClientError = Class.new(self)
    ServerError = Class.new(self)

    BadRequest = Class.new(ClientError)
    Unauthorized = Class.new(ClientError)
    NotAcceptable = Class.new(ClientError)
    NotFound = Class.new(ClientError)
    Conflict = Class.new(ClientError)
    TooManyRequests = Class.new(ClientError)
    Forbidden = Class.new(ClientError)
    Locked = Class.new(ClientError)
    MethodNotAllowed = Class.new(ClientError)

    NotImplemented = Class.new(ServerError)
    BadGateway = Class.new(ServerError)
    ServiceUnavailable = Class.new(ServerError)
    GatewayTimeout = Class.new(ServerError)

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
        msg = body.key?('error') ? body['error']['message'] : body['message']
        new msg.to_s
      end
    end

    # Initializes a new Error object
    def initialize(message = '')
      super(message)
    end
  end
end

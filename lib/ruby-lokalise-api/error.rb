# frozen_string_literal: true

module Lokalise
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
    MethodNowAllowed = Class.new(ClientError)

    NotImplemented = Class.new(ServerError)
    BadGateway = Class.new(ServerError)
    ServiceUnavailable = Class.new(ServerError)
    GatewayTimeout = Class.new(ServerError)

    ERRORS = {
      400 => Lokalise::Error::BadRequest,
      401 => Lokalise::Error::Unauthorized,
      403 => Lokalise::Error::Forbidden,
      404 => Lokalise::Error::NotFound,
      405 => Lokalise::Error::MethodNowAllowed,
      406 => Lokalise::Error::NotAcceptable,
      409 => Lokalise::Error::Conflict,
      423 => Lokalise::Error::Locked,
      429 => Lokalise::Error::TooManyRequests,
      500 => Lokalise::Error::ServerError,
      502 => Lokalise::Error::BadGateway,
      503 => Lokalise::Error::ServiceUnavailable,
      504 => Lokalise::Error::GatewayTimeout
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

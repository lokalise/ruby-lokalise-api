module Lokalise
  class Error < StandardError
    # TODO: define error codes
    #
    ClientError = Class.new(self)
    ServerError = Class.new(self)

    EagerLoadingNotSupported = Class.new(ClientError) do
      def to_s
        'Eager loading is not supported for this resource.'
      end
    end

    NotHashType = Class.new(ClientError) do
      def to_s
        'This is not a hash-like collection, so it cannot be converted to an ordinary hash.'
      end
    end

    NotArrayType = Class.new(ClientError) do
      def to_s
        'This is not an array-like collection, so it cannot be converted to an ordinary array.'
      end
    end

    BadRequest = Class.new(ServerError)
    NotFound = Class.new(ServerError)
    NotImplemented = Class.new(ServerError)

    ERRORS = {
      400 => Lokalise::Error::BadRequest,
      404 => Lokalise::Error::NotFound,
      501 => Lokalise::Error::NotImplemented
    }

    class << self
      # Create a new error from an HTTP response
      def from_response(body)
        new(body.to_s)
      end
    end

    # Initializes a new Error object
    def initialize(message = '')
      super(message)
    end
  end
end
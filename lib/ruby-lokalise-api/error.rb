module Lokalise
  class Error < StandardError
    # TODO: define error codes
    #
    ClientError = Class.new(self)
    ServerError = Class.new(self)

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
        new(body['error']['message'].to_s)
      end
    end

    # Initializes a new Error object
    def initialize(message = '')
      super(message)
    end
  end
end
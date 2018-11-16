module Lokalise
  class Client
    attr_reader :token

    def initialize(token)
      @token = token
    end
  end
end
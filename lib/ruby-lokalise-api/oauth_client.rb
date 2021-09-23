module Lokalise
  class OAuthClient < Client
    def initialize(token, params = {})
      super(token, params)
      @token_header = 'Authorization'
      @token = "Bearer #{@token}"
    end
  end
end
# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Jwt
      # Returns a JWT that can be used to work with OTA
      #
      # @see https://developers.lokalise.com/reference/get-ota-jwt
      # @return [RubyLokaliseApi::Resources::Jwt]
      def jwt
        c_r RubyLokaliseApi::Resources::Jwt, :find, nil, {}
      end
    end
  end
end

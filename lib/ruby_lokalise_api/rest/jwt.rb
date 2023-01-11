# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Jwt
      # Returns a JWT that can be used to work with OTA
      #
      # @see https://developers.lokalise.com/reference/create-service-jwt
      # @return [RubyLokaliseApi::Resources::Jwt]
      def jwt(project_id, params = {service: :ota})
        c_r RubyLokaliseApi::Resources::Jwt, :create, project_id, params
      end
    end
  end
end

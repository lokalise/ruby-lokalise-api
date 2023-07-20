# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Jwts
      # Creates a service JWT
      #
      # @see https://developers.lokalise.com/reference/create-service-jwt
      # @return [RubyLokaliseApi::Resources::Jwt]
      # @param project_id [String]
      # @param req_params [Hash]
      def create_jwt(project_id, req_params)
        params = { query: project_id, req: req_params }

        data = endpoint(name: 'Jwts', params: params).do_post

        resource 'Jwt', data
      end
    end
  end
end

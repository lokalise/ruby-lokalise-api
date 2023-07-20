# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class MainEndpoint < BaseEndpoint
      BASE_URL = 'https://api.lokalise.com/api2'

      def initialize(client, params = {})
        super client, params

        @uri = partial_uri(base_query(*@query_params))
      end

      private

      def partial_uri(segments, *_args)
        template = super

        template.expand(
          segments: segments.to_a.flatten
        ).to_s
      end
    end
  end
end

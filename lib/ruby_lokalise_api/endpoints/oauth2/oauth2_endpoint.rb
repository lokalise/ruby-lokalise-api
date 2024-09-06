# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    module OAuth2
      class OAuth2Endpoint < BaseEndpoint
        BASE_URL = 'https://app.lokalise.com/oauth2'
        PARTIAL_URI_TEMPLATE = '{/segments*}{?query*}'

        def initialize(client, params = {})
          super

          @uri = build_uri(params.fetch(:get, []))
        end

        private

        # Builds the complete URI for the OAuth2 endpoint
        def build_uri(query)
          partial_uri(base_query(*@query_params), query)
        end

        def partial_uri(segments, query)
          template = super

          template.expand(
            segments: segments.to_a.flatten,
            query: filter_query_params(query)
          ).to_s
        end

        # Filters out nil values from query parameters
        def filter_query_params(query)
          query.compact
        end

        def base_query(segment = nil)
          [segment]
        end
      end
    end
  end
end

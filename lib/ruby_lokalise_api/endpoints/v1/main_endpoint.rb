# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    module V1
      class MainEndpoint < BaseEndpoint
        BASE_URL = 'https://api.lokalise.com/v1'

        def initialize(client, params = {})
          super

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
end

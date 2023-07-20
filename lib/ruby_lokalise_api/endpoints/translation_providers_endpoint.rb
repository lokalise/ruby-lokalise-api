# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class TranslationProvidersEndpoint < MainEndpoint
      private

      def base_query(team_id, provider_id = nil)
        {
          teams: team_id,
          translation_providers: provider_id
        }
      end
    end
  end
end

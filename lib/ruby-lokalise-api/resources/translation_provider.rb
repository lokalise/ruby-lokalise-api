# frozen_string_literal: true

module Lokalise
  module Resources
    class TranslationProvider < Base
      supports [:reload_data, '', :find]
      ID_KEY = 'provider'

      class << self
        def endpoint(team_id, provider_id = nil)
          path_from teams: team_id,
                    translation_providers: provider_id
        end
      end
    end
  end
end

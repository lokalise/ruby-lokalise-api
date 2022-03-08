# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class TranslationProvider < Base
      supports [:reload_data, '', :find]
      ID_KEY = 'provider_id'

      class << self
        def endpoint(team_id, provider_id = nil)
          path_from teams: team_id,
                    translation_providers: provider_id
        end
      end
    end
  end
end

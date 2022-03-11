# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class TranslationProvider < Base
      class << self
        def endpoint(team_id, *_args)
          path_from teams: [team_id, 'translation_providers']
        end
      end
    end
  end
end

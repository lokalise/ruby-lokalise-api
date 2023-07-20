# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class TranslationProvider < Base
      MAIN_PARAMS = %i[team_id provider_id].freeze
      no_support_for %i[update destroy]
    end
  end
end

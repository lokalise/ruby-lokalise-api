# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class TranslationMemory < Base
      MAIN_PARAMS = %i[project_id id].freeze

      no_support_for %i[update destroy reload_data]
    end
  end
end

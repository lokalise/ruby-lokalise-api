# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class ProjectLanguage < Base
      MAIN_PARAMS = %i[project_id lang_id].freeze
      DATA_KEY = 'language'
    end
  end
end

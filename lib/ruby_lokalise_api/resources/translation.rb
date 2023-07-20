# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Translation < Base
      MAIN_PARAMS = %i[project_id translation_id].freeze
      no_support_for %i[destroy]
    end
  end
end

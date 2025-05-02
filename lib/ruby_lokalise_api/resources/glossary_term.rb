# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class GlossaryTerm < Base
      MAIN_PARAMS = %i[projectId id].freeze
      DATA_KEY = 'data'
      no_support_for %i[update destroy]
    end
  end
end

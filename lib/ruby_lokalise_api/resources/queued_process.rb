# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class QueuedProcess < Base
      MAIN_PARAMS = %i[project_id process_id].freeze
      no_support_for %i[update destroy]
      DATA_KEY = 'process'
    end
  end
end

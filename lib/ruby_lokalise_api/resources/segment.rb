# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Segment < Base
      MAIN_PARAMS = %i[project_id key_id language_iso segment_number].freeze
      no_support_for %i[destroy]
    end
  end
end

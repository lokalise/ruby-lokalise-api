# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class File < Base
      MAIN_PARAMS = %i[project_id file_id].freeze
      no_support_for %i[update reload_data]
    end
  end
end

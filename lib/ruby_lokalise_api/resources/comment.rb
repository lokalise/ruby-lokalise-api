# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Comment < Base
      MAIN_PARAMS = %i[project_id key_id comment_id].freeze

      no_support_for %i[update]
    end
  end
end

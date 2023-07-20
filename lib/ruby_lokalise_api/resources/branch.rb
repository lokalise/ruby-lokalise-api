# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Branch < Base
      MAIN_PARAMS = %i[project_id branch_id].freeze

      delegate_call :merge, :merge_branch
    end
  end
end

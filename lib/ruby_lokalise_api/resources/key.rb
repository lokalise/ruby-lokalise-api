# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Key < Base
      MAIN_PARAMS = %i[project_id key_id].freeze

      delegate_call :key_comment, :comment
      delegate_call :key_comments, :comments
      delegate_call :create_comments
      delegate_call :destroy_comment
    end
  end
end

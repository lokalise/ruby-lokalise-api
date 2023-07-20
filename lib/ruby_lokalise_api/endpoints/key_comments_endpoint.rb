# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class KeyCommentsEndpoint < MainEndpoint
      private

      def base_query(project_id, key_id, comment_id = nil)
        {
          projects: project_id,
          keys: key_id,
          comments: comment_id
        }
      end
    end
  end
end

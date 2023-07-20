# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class FilesEndpoint < MainEndpoint
      private

      def base_query(project_id, action = nil)
        {
          projects: project_id,
          files: action
        }
      end
    end
  end
end

# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class ProjectCommentsEndpoint < MainEndpoint
      private

      def base_query(project_id)
        {
          projects: [project_id, :comments]
        }
      end
    end
  end
end

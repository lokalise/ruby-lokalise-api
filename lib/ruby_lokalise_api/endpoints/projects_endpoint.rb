# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class ProjectsEndpoint < MainEndpoint
      private

      def base_query(project_id = nil, action = nil)
        {
          projects: [project_id, action]
        }
      end
    end
  end
end

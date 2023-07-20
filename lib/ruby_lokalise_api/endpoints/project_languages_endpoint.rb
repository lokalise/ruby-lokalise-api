# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class ProjectLanguagesEndpoint < MainEndpoint
      private

      def base_query(project_id, language_id = nil)
        {
          projects: project_id,
          languages: language_id
        }
      end
    end
  end
end

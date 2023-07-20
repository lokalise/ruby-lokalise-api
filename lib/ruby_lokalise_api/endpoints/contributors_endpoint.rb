# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class ContributorsEndpoint < MainEndpoint
      private

      def base_query(project_id, contributor_id = nil)
        {
          projects: project_id,
          contributors: contributor_id
        }
      end
    end
  end
end

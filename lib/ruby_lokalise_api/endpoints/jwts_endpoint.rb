# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class JwtsEndpoint < MainEndpoint
      private

      def base_query(project_id)
        {
          projects: [project_id, :tokens]
        }
      end
    end
  end
end

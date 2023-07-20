# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class CustomTranslationStatusesEndpoint < MainEndpoint
      private

      def base_query(project_id, status_id = nil)
        {
          projects: project_id,
          custom_translation_statuses: status_id
        }
      end
    end
  end
end

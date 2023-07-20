# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class ScreenshotsEndpoint < MainEndpoint
      private

      def base_query(project_id, screenshots_id = nil)
        {
          projects: project_id,
          screenshots: screenshots_id
        }
      end
    end
  end
end

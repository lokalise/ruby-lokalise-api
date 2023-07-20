# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class SegmentsEndpoint < MainEndpoint
      private

      def base_query(project_id, key_id, language_iso, segment_number = nil)
        {
          projects: project_id,
          keys: key_id,
          segments: [language_iso, segment_number]
        }
      end
    end
  end
end

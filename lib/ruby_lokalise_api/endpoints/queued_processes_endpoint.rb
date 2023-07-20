# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class QueuedProcessesEndpoint < MainEndpoint
      private

      def base_query(project_id, process_id = nil)
        {
          projects: project_id,
          processes: process_id
        }
      end
    end
  end
end

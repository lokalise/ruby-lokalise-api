# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class SnapshotsEndpoint < MainEndpoint
      private

      def base_query(project_id, snapshot_id = nil)
        {
          projects: project_id,
          snapshots: snapshot_id
        }
      end
    end
  end
end

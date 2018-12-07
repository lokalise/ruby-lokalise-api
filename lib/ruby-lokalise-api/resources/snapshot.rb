module Lokalise
  module Resources
    class Snapshot < Base
      class << self
        def restore(client, project_id, snapshot_id)
          Lokalise::Resources::Project.new post(endpoint(project_id, snapshot_id), client)
        end

        private

        def endpoint(project_id, snapshot_id = nil)
          "projects/#{project_id}/snapshots/#{snapshot_id}"
        end
      end
    end
  end
end

module Lokalise
  module Resources
    class Snapshot < Base
      class << self
        def create(token, project_id, params)
          create_record endpoint(project_id), token, params
        end

        def restore(token, project_id, snapshot_id)
          Lokalise::Resources::Project.new post(endpoint(project_id) + '/' + snapshot_id, token)
        end

        def destroy(token, project_id, snapshot_id)
          destroy_record endpoint(project_id), token, snapshot_id
        end

        private

        def endpoint(project_id)
          "projects/#{project_id}/snapshots"
        end
      end
    end
  end
end
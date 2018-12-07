module Lokalise
  class Client
    def snapshots(project_id, params = {})
      Lokalise::Collections::Snapshot.all self, params, project_id
    end

    def create_snapshot(project_id, params = {})
      Lokalise::Resources::Snapshot.create self, project_id, params
    end

    def restore_snapshot(project_id, snapshot_id)
      Lokalise::Resources::Snapshot.restore self, project_id, snapshot_id
    end

    def delete_snapshot(project_id, snapshot_id)
      Lokalise::Resources::Snapshot.destroy self, project_id, snapshot_id
    end
  end
end

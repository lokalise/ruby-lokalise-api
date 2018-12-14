module Lokalise
  module Resources
    class Snapshot < Base
      supports :destroy

      def restore
        self.class.restore @client, @path
      end

      class << self
        def restore(client, path, *_args)
          Lokalise::Resources::Project.new post(path, client)
        end

        def endpoint(project_id, snapshot_id = nil)
          path_from projects: project_id,
                    snapshots: snapshot_id
        end
      end
    end
  end
end

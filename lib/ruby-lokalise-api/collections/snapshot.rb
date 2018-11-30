module Lokalise
  module Collections
    class Snapshot < Base
      class << self
        private

        def endpoint(project_id, *_args)
          "projects/#{project_id}/snapshots"
        end
      end
    end
  end
end

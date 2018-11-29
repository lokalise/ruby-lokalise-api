module Lokalise
  module Collections
    class ProjectComment < Base
      class << self
        private

        def endpoint(project_id, *_args)
          "projects/#{project_id}/comments"
        end
      end
    end
  end
end

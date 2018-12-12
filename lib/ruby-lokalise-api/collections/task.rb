module Lokalise
  module Collections
    class Task < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'tasks']
        end
      end
    end
  end
end

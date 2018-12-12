module Lokalise
  module Resources
    class Task < Base
      class << self
        def endpoint(project_id, task_id = nil)
          path_from projects: project_id,
                    tasks: task_id
        end
      end
    end
  end
end

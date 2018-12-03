module Lokalise
  module Resources
    class Task < Base
      class << self
        private

        def endpoint(project_id)
          "projects/#{project_id}/tasks"
        end
      end
    end
  end
end

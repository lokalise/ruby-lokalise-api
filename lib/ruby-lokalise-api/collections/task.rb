module Lokalise
  module Collections
    class Task < Base
      class << self
        private

        def endpoint(project_id, *_args)
          "projects/#{project_id}/tasks"
        end
      end
    end
  end
end

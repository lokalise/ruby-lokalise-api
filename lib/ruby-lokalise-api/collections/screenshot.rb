module Lokalise
  module Collections
    class Screenshot < Base
      class << self
        private

        def endpoint(project_id, *_args)
          "projects/#{project_id}/screenshots"
        end
      end
    end
  end
end

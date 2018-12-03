module Lokalise
  module Resources
    class Screenshot < Base
      class << self
        private

        def endpoint(project_id)
          "projects/#{project_id}/screenshots"
        end
      end
    end
  end
end

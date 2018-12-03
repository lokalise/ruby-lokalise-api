module Lokalise
  module Resources
    class Translation < Base
      class << self
        private

        def endpoint(project_id)
          "projects/#{project_id}/translations"
        end
      end
    end
  end
end

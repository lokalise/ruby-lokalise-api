module Lokalise
  module Resources
    class Contributor < Base
      class << self
        private

        def endpoint(project_id)
          "projects/#{project_id}/contributors"
        end
      end
    end
  end
end

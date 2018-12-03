module Lokalise
  module Resources
    class ProjectLanguage < Base
      class << self
        private

        def endpoint(project_id)
          "projects/#{project_id}/languages"
        end
      end
    end
  end
end

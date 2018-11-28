module Lokalise
  module Resources
    class ProjectLanguage < Base
      class << self
        def find(token, project_id, language_id)
          load_record endpoint(project_id), token, language_id
        end

        private

        def endpoint(project_id)
          "projects/#{project_id}/languages"
        end
      end
    end
  end
end

module Lokalise
  module Resources
    class Translation < Base
      class << self
        def find(token, project_id, translation_id, params = {})
          load_record endpoint(project_id), token, translation_id, params
        end

        def update(token, project_id, translation_id, params)
          update_record endpoint(project_id) + '/' + translation_id, token, params
        end

        private

        def endpoint(project_id)
          "projects/#{project_id}/translations"
        end
      end
    end
  end
end

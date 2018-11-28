module Lokalise
  module Resources
    class ProjectLanguage < Base
      class << self
        def find(token, project_id, language_id)
          load_record endpoint(project_id), token, language_id
        end

        def create(token, project_id, params)
          params = [params] unless params.is_a?(Array)
          create_record endpoint(project_id), token, languages: params
        end

        def update(token, project_id, language_id, params)
          update_record endpoint_with_id(project_id, language_id), token, params
        end

        def destroy(token, project_id, language_id)
          destroy_record endpoint(project_id), token, language_id
        end

        private

        def endpoint(project_id)
          "projects/#{project_id}/languages"
        end

        def endpoint_with_id(project_id, language_id)
          "projects/#{project_id}/languages/#{language_id}"
        end
      end
    end
  end
end

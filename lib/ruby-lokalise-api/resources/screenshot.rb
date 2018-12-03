module Lokalise
  module Resources
    class Screenshot < Base
      class << self
        def find(token, project_id, screenshot_id)
          load_record endpoint(project_id), token, screenshot_id
        end

        def create(token, project_id, params)
          params = [params] unless params.is_a?(Array)
          create_record endpoint(project_id), token, screenshots: params
        end

        def update(token, project_id, screenshot_id, params = {})
          update_record endpoint(project_id) + '/' + screenshot_id, token, params
        end

        def destroy(token, project_id, screenshot_id)
          destroy_record endpoint(project_id), token, screenshot_id
        end

        private

        def endpoint(project_id)
          "projects/#{project_id}/screenshots"
        end
      end
    end
  end
end

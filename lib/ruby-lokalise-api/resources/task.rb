module Lokalise
  module Resources
    class Task < Base
      class << self
        def find(token, project_id, task_id)
          load_record endpoint(project_id), token, task_id
        end

        def create(token, project_id, params)
          create_record endpoint(project_id), token, params
        end

        def update(token, project_id, task_id, params)
          update_record endpoint(project_id) + '/' + task_id, token, params
        end

        def destroy(token, project_id, task_id)
          destroy_record endpoint(project_id), token, task_id
        end

        private

        def endpoint(project_id)
          "projects/#{project_id}/tasks"
        end
      end
    end
  end
end

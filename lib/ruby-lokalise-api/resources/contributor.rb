module Lokalise
  module Resources
    class Contributor < Base
      class << self
        def find(token, project_id, contributor_id)
          load_record endpoint(project_id), token, contributor_id
        end

        def create(token, project_id, params)
          params = [params] unless params.is_a?(Array)
          create_record endpoint(project_id), token, contributors: params
        end

        def update(token, project_id, contributor_id, params)
          update_record endpoint(project_id) + "/#{contributor_id}", token, params
        end

        def destroy(token, project_id, contributor_id)
          destroy_record endpoint(project_id), token, contributor_id
        end

        private

        def endpoint(project_id)
          "projects/#{project_id}/contributors"
        end
      end
    end
  end
end

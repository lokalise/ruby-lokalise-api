module Lokalise
  module Resources
    class Key < Base
      class << self
        def find(token, project_id, key_id, params = {})
          load_record endpoint(project_id), token, key_id, params
        end

        def create(token, project_id, params)
          params = [params] unless params.is_a?(Array)
          create_record endpoint(project_id), token, keys: params
        end

        def update(token, project_id, key_id, params = {})
          update_record endpoint(project_id) + '/' + key_id, token, params
        end

        def bulk_update(token, project_id, params)
          params = [params] unless params.is_a?(Array)
          update_record endpoint(project_id), token, keys: params
        end

        def destroy(token, project_id, key_id)
          destroy_record endpoint(project_id), token, key_id
        end

        def bulk_destroy(token, project_id, key_ids)
          destroy_record endpoint(project_id), token, keys: key_ids
        end

        private

        def endpoint(project_id)
          "projects/#{project_id}/keys"
        end
      end
    end
  end
end
module Lokalise
  module Resources
    class KeyComment < Base
      class << self
        def find(token, project_id, key_id, comment_id)
          load_record endpoint(project_id, key_id), token, comment_id
        end

        def create(token, project_id, key_id, params)
          params = [params] unless params.is_a?(Array)
          create_record endpoint(project_id, key_id), token, comments: params
        end

        def destroy(token, project_id, key_id, comment_id)
          destroy_record endpoint(project_id, key_id), token, comment_id
        end

        private

        def endpoint(project_id, key_id)
          "projects/#{project_id}/keys/#{key_id}/comments"
        end

        def endpoint_with_id(project_id, key_id, comment_id)
          "#{endpoint(project_id, key_id)}/#{comment_id}"
        end
      end
    end
  end
end

module Lokalise
  module Resources
    class Project < Base
      class << self
        def find(token, project_id)
          load_record endpoint, token, project_id
        end

        def create(token, params)
          create_record endpoint, token, params
        end

        def update(token, project_id, params)
          update_record endpoint_with_id(project_id), token, params
        end

        def clear(token, project_id)
          update_record "#{endpoint_with_id(project_id)}/empty", token
        end

        def destroy(token, project_id)
          destroy_record endpoint, token, project_id
        end
      end

      private

      def self.endpoint
        'projects'
      end

      def self.endpoint_with_id(project_id)
        "#{endpoint}/#{project_id}"
      end
    end
  end
end
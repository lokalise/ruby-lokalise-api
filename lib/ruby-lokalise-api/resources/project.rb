module Lokalise
  module Resources
    class Project < Base
      ENDPOINT = 'projects'.freeze

      class << self
        def find(token, project_id)
          load_record ENDPOINT, token, project_id
        end

        def create(token, params)
          create_record ENDPOINT, token, params
        end

        def update(token, project_id, params)
          update_record "#{ENDPOINT}/#{project_id}", token, params
        end

        def clear(token, project_id)
          update_record "#{ENDPOINT}/#{project_id}/empty", token
        end

        def destroy(token, project_id)
          destroy_record ENDPOINT, token, project_id
        end
      end
    end
  end
end
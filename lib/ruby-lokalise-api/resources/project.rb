module Lokalise
  module Resources
    class Project < Base
      class << self
        def clear(client, project_id)
          put("#{endpoint(project_id)}/empty", client)['content']
        end

        private

        def endpoint(project_id = nil)
          'projects' unless project_id
          "projects/#{project_id}"
        end
      end
    end
  end
end

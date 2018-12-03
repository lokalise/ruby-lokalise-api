module Lokalise
  module Resources
    class Project < Base
      class << self
        def clear(token, project_id)
          new put("#{endpoint(project_id)}/empty",
                  token,
                  params)
        end

        private

        def endpoint(project_id = nil)
          "projects/#{project_id}"
        end
      end
    end
  end
end

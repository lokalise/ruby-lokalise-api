module Lokalise
  module Resources
    class File < Base
      class << self
        def download(token, project_id, params)
          new post("#{endpoint(project_id)}/download",
                   token,
                   params)
        end

        def upload(token, project_id, params)
          new post("#{endpoint(project_id)}/upload",
                   token,
                   params)
        end

        private

        def endpoint(project_id)
          "projects/#{project_id}/files"
        end
      end
    end
  end
end

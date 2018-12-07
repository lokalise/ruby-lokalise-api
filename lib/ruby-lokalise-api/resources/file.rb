module Lokalise
  module Resources
    class File < Base
      class << self
        def download(client, project_id, params)
          up_down client, endpoint(project_id), params, 'download'
        end

        def upload(client, project_id, params)
          up_down client, endpoint(project_id), params, 'upload'
        end

        private

        def up_down(client, path, params, action)
          post("#{path}/#{action}", client, params)['content']
        end

        def endpoint(project_id)
          "projects/#{project_id}/files"
        end
      end
    end
  end
end

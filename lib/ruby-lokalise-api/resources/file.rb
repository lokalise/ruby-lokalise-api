module Lokalise
  module Resources
    class File < Base
      class << self
        def download(token, project_id, params)
          up_down token, endpoint(project_id), params, 'download'
        end

        def upload(token, project_id, params)
          up_down token, endpoint(project_id), params, 'upload'
        end

        private

        def up_down(token, path, params, action)
          post "#{path}/#{action}", token, params
        end

        def endpoint(project_id)
          "projects/#{project_id}/files"
        end
      end
    end
  end
end

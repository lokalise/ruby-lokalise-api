module Lokalise
  module Resources
    class File < Base
      class << self
        def download(client, path, params)
          post(path, client, params)['content']
        end

        def upload(client, path, params)
          post(path, client, params)['content']
        end

        def endpoint(project_id, action = '')
          path_from projects: project_id,
                    files: action
        end
      end
    end
  end
end

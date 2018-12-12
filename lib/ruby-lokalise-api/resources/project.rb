module Lokalise
  module Resources
    class Project < Base
      class << self
        def empty(client, path, *_args)
          put(path, client)['content']
        end

        def endpoint(project_id = nil, action = nil)
          path_from projects: [project_id, action]
        end
      end
    end
  end
end

module Lokalise
  module Collections
    class Key < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'keys']
        end
      end
    end
  end
end

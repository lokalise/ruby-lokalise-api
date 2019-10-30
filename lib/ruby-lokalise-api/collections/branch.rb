module Lokalise
  module Collections
    class Branch < Base
      DATA_KEY_PLURAL = 'Branches'.freeze

      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'branches']
        end
      end
    end
  end
end

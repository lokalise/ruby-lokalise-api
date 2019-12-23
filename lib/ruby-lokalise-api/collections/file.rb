# frozen_string_literal: true

module Lokalise
  module Collections
    class File < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'files']
        end
      end
    end
  end
end

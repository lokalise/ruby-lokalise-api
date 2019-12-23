# frozen_string_literal: true

module Lokalise
  module Collections
    class Screenshot < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'screenshots']
        end
      end
    end
  end
end

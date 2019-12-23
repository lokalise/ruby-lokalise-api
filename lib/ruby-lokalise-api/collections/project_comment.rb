# frozen_string_literal: true

module Lokalise
  module Collections
    class ProjectComment < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'comments']
        end
      end
    end
  end
end

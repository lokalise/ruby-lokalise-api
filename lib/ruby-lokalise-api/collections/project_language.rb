# frozen_string_literal: true

module Lokalise
  module Collections
    class ProjectLanguage < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'languages']
        end
      end
    end
  end
end

module Lokalise
  module Collections
    class ProjectLanguage < Base
      class << self
        private

        def endpoint(project_id, *_args)
          "projects/#{project_id}/languages"
        end
      end
    end
  end
end

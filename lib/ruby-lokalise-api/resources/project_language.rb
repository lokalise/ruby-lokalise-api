module Lokalise
  module Resources
    class ProjectLanguage < Base
      DATA_KEY = 'Language'.freeze

      class << self
        def endpoint(project_id, language_id = nil)
          path_from projects: project_id,
                    languages: language_id
        end
      end
    end
  end
end

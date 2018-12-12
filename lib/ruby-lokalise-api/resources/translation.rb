module Lokalise
  module Resources
    class Translation < Base
      class << self
        def endpoint(project_id, translation_id = nil)
          path_from projects: project_id,
                    translations: translation_id
        end
      end
    end
  end
end

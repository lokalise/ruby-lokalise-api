module Lokalise
  module Resources
    class Screenshot < Base
      class << self
        def endpoint(project_id, screenshot_id = nil)
          path_from projects: project_id,
                    screenshots: screenshot_id
        end
      end
    end
  end
end

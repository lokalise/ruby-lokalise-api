module Lokalise
  module Collections
    class Translation < Base
      class << self
        private

        def endpoint(project_id, *_args)
          "projects/#{project_id}/translations"
        end
      end
    end
  end
end

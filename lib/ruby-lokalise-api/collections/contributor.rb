module Lokalise
  module Collections
    class Contributor < Base
      class << self
        private

        def endpoint(project_id, *_args)
          "projects/#{project_id}/contributors"
        end
      end
    end
  end
end

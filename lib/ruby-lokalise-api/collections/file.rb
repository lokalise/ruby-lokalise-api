module Lokalise
  module Collections
    class File < Base
      class << self
        private

        def endpoint(project_id, *_args)
          "projects/#{project_id}/files"
        end
      end
    end
  end
end

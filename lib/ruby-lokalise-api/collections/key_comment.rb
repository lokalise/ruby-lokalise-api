module Lokalise
  module Collections
    class KeyComment < Base
      class << self
        private

        def endpoint(project_id, key_id, *_args)
          "projects/#{project_id}/keys/#{key_id}/comments"
        end
      end
    end
  end
end

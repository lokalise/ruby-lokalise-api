module Lokalise
  module Resources
    class KeyComment < Base
      DATA_KEY = 'Comment'.freeze

      class << self
        private

        def endpoint(project_id, key_id)
          "projects/#{project_id}/keys/#{key_id}/comments"
        end
      end
    end
  end
end

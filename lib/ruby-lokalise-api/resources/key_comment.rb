module Lokalise
  module Resources
    class KeyComment < Base
      class << self
        private

        def endpoint(project_id, key_id)
          "projects/#{project_id}/keys/#{key_id}/comments"
        end
      end
    end
  end
end

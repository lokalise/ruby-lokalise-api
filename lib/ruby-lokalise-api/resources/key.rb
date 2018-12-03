module Lokalise
  module Resources
    class Key < Base
      class << self
        private

        def endpoint(project_id)
          "projects/#{project_id}/keys"
        end
      end
    end
  end
end
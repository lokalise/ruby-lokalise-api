# frozen_string_literal: true

module Lokalise
  module Resources
    class Translation < Base
      supports :update

      class << self
        def endpoint(project_id, translation_id = nil)
          path_from projects: project_id,
                    translations: translation_id
        end
      end
    end
  end
end

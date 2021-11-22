# frozen_string_literal: true

module Lokalise
  module Resources
    class Contributor < Base
      ID_KEY = 'user_id'
      supports :update, :destroy, [:reload_data, '', :find]

      class << self
        def endpoint(project_id, contributor_id = nil)
          path_from projects: project_id,
                    contributors: contributor_id
        end
      end
    end
  end
end

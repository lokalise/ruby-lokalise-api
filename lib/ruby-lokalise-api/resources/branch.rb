module Lokalise
  module Resources
    class Branch < Base
      supports :update, :destroy

      class << self
        def endpoint(project_id, branch_id = nil)
          path_from projects: project_id,
                    branches: branch_id
        end
      end
    end
  end
end

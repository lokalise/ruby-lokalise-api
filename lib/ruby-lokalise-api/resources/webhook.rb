module Lokalise
  module Resources
    class Webhook < Base
      supports :update, :destroy

      class << self
        def endpoint(project_id, webhook_id = nil)
          path_from projects: project_id,
                    webhooks: webhook_id
        end
      end
    end
  end
end

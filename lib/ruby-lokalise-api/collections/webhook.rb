module Lokalise
  module Collections
    class Webhook < Base
      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'webhooks']
        end
      end
    end
  end
end

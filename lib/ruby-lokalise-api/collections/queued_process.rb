# frozen_string_literal: true

module Lokalise
  module Collections
    class QueuedProcess < Base
      DATA_KEY_PLURAL = 'Processes'

      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'processes']
        end
      end
    end
  end
end

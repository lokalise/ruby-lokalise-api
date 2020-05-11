# frozen_string_literal: true

module Lokalise
  module Resources
    class QueuedProcess < Base
      DATA_KEY = 'Process'
      ID_KEY = 'process'
      supports [:reload_data, '', :find]

      class << self
        def endpoint(project_id, process_id = nil, *actions)
          path_from projects: project_id,
                    processes: [actions, process_id]
        end
      end
    end
  end
end

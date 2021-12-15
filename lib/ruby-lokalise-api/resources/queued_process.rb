# frozen_string_literal: true

module Lokalise
  module Resources
    class QueuedProcess < Base
      DATA_KEY = 'Process'
      ID_KEY = 'process_id'
      supports [:reload_data, '', :find]

      class << self
        def endpoint(project_id, process_id = nil)
          path_from projects: project_id,
                    processes: process_id
        end
      end
    end
  end
end

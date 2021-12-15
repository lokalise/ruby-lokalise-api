# frozen_string_literal: true

module Lokalise
  module Resources
    class Task < Base
      ID_KEY = 'task_id'
      supports :update, :destroy, [:reload_data, '', :find]

      class << self
        def endpoint(project_id, task_id = nil)
          path_from projects: project_id,
                    tasks: task_id
        end
      end
    end
  end
end

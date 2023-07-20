# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class TasksEndpoint < MainEndpoint
      private

      def base_query(project_id, task_id = nil)
        {
          projects: project_id,
          tasks: task_id
        }
      end
    end
  end
end

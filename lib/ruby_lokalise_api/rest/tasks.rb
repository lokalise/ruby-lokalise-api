# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Tasks
      # Returns project tasks
      #
      # @see https://developers.lokalise.com/reference/list-all-tasks
      # @return [RubyLokaliseApi::Collections::Tasks]
      # @param project_id [String]
      # @param req_params [Hash]
      def tasks(project_id, req_params = {})
        name = 'Tasks'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single task
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-task
      # @return [RubyLokaliseApi::Resources::Task]
      # @param project_id [String]
      # @param task_id [String, Integer]
      # @param req_params[Hash]
      def task(project_id, task_id, req_params = {})
        params = { query: [project_id, task_id], req: req_params }

        data = endpoint(name: 'Tasks', params: params).do_get

        resource 'Task', data
      end

      # Creates a new task
      #
      # @see https://developers.lokalise.com/reference/create-a-task
      # @return [RubyLokaliseApi::Resources::Task]
      # @param project_id [String]
      # @param req_params [Hash, Array]
      def create_task(project_id, req_params)
        params = { query: project_id, req: req_params }

        data = endpoint(name: 'Tasks', params: params).do_post

        resource 'Task', data
      end

      # Updates a task
      #
      # @see https://developers.lokalise.com/reference/update-a-task
      # @return [RubyLokaliseApi::Resources::Task]
      # @param project_id [String]
      # @param task_id [String, Integer]
      # @param req_params [Hash]
      def update_task(project_id, task_id, req_params = {})
        params = { query: [project_id, task_id], req: req_params }

        data = endpoint(name: 'Tasks', params: params).do_put

        resource 'Task', data
      end

      # Deletes a task
      #
      # @see https://developers.lokalise.com/reference/delete-a-task
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param task_id [String, Integer]
      def destroy_task(project_id, task_id)
        params = { query: [project_id, task_id] }

        data = endpoint(name: 'Tasks', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end

# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Tasks
      # Returns all tasks for the given project
      #
      # @see https://developers.lokalise.com/reference/list-all-tasks
      # @return [RubyLokaliseApi::Collection::Task<RubyLokaliseApi::Resources::Task>]
      # @param project_id [String]
      # @param params [Hash]
      def tasks(project_id, params = {})
        c_r RubyLokaliseApi::Collections::Task, :all, project_id, params
      end

      # Returns a single task for the given project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-task
      # @return [RubyLokaliseApi::Resources::Task]
      # @param project_id [String]
      # @param task_id [String, Integer]
      def task(project_id, task_id)
        c_r RubyLokaliseApi::Resources::Task, :find, [project_id, task_id]
      end

      # Creates task for the given project
      #
      # @see https://developers.lokalise.com/reference/create-a-task
      # @return [RubyLokaliseApi::Resources::Task]
      # @param project_id [String]
      # @param params [Hash]
      def create_task(project_id, params)
        c_r RubyLokaliseApi::Resources::Task, :create, project_id, params
      end

      # Updates task for the given project
      #
      # @see https://developers.lokalise.com/reference/update-a-task
      # @return [RubyLokaliseApi::Resources::Task]
      # @param project_id [String]
      # @param task_id [String, Integer]
      # @param params [Hash]
      def update_task(project_id, task_id, params = {})
        c_r RubyLokaliseApi::Resources::Task, :update, [project_id, task_id], params
      end

      # Deletes task for the given project
      #
      # @see https://developers.lokalise.com/reference/delete-a-task
      # @return [Hash]
      # @param project_id [String]
      # @param task_id [String, Integer]
      def destroy_task(project_id, task_id)
        c_r RubyLokaliseApi::Resources::Task, :destroy, [project_id, task_id]
      end
    end
  end
end

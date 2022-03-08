# frozen_string_literal: true

module RubyLokaliseApi
  class Client
    # Returns all tasks for the given project
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-tasks-get
    # @return [RubyLokaliseApi::Collection::Task<RubyLokaliseApi::Resources::Task>]
    # @param project_id [String]
    # @param params [Hash]
    def tasks(project_id, params = {})
      c_r RubyLokaliseApi::Collections::Task, :all, project_id, params
    end

    # Returns a single task for the given project
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-task-get
    # @return [RubyLokaliseApi::Resources::Task]
    # @param project_id [String]
    # @param task_id [String, Integer]
    def task(project_id, task_id)
      c_r RubyLokaliseApi::Resources::Task, :find, [project_id, task_id]
    end

    # Creates task for the given project
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-create-a-task-post
    # @return [RubyLokaliseApi::Resources::Task]
    # @param project_id [String]
    # @param params [Hash]
    def create_task(project_id, params)
      c_r RubyLokaliseApi::Resources::Task, :create, project_id, params
    end

    # Updates task for the given project
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-update-a-task-put
    # @return [RubyLokaliseApi::Resources::Task]
    # @param project_id [String]
    # @param task_id [String, Integer]
    # @param params [Hash]
    def update_task(project_id, task_id, params = {})
      c_r RubyLokaliseApi::Resources::Task, :update, [project_id, task_id], params
    end

    # Deletes task for the given project
    #
    # @see https://app.lokalise.com/api2docs/curl/#transition-delete-a-task-delete
    # @return [Hash]
    # @param project_id [String]
    # @param task_id [String, Integer]
    def destroy_task(project_id, task_id)
      c_r RubyLokaliseApi::Resources::Task, :destroy, [project_id, task_id]
    end
  end
end

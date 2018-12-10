module Lokalise
  class Client
    # Returns all tasks for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-tasks-get
    # @return [Lokalise::Collection::Task<Lokalise::Resources::Task>]
    # @param project_id [String]
    # @param params [Hash]
    def tasks(project_id, params = {})
      Lokalise::Collections::Task.all self, params, project_id
    end

    # Returns a single task for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-task-get
    # @return [Lokalise::Resources::Task]
    # @param project_id [String]
    # @param task_id [String, Integer]
    def task(project_id, task_id)
      Lokalise::Resources::Task.find self, project_id, task_id
    end

    # Creates task for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-a-task-post
    # @return [Lokalise::Resources::Task]
    # @param project_id [String]
    # @param params [Hash]
    def create_task(project_id, params)
      Lokalise::Resources::Task.create self, project_id, params
    end

    # Updates task for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-task-put
    # @return [Lokalise::Resources::Task]
    # @param project_id [String]
    # @param task_id [String, Integer]
    # @param params [Hash]
    def update_task(project_id, task_id, params = {})
      Lokalise::Resources::Task.update self, project_id, task_id, params
    end

    # Deletes task for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-task-delete
    # @return [Hash]
    # @param project_id [String]
    # @param task_id [String, Integer]
    def delete_task(project_id, task_id)
      Lokalise::Resources::Task.destroy self, project_id, task_id
    end
  end
end

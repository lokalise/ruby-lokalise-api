module Lokalise
  class Client
    def tasks(project_id, params = {})
      Lokalise::Collections::Task.all self, params, project_id
    end

    def task(project_id, task_id)
      Lokalise::Resources::Task.find self, project_id, task_id
    end

    def create_task(project_id, params)
      Lokalise::Resources::Task.create self, project_id, params
    end

    def update_task(project_id, task_id, params = {})
      Lokalise::Resources::Task.update self, project_id, task_id, params
    end

    def delete_task(project_id, task_id)
      Lokalise::Resources::Task.destroy self, project_id, task_id
    end
  end
end

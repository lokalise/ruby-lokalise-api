module Lokalise
  class Client
    def tasks(project_id, params = {})
      Lokalise::Collections::Task.all @token, params, project_id
    end

    def task(project_id, task_id)
      Lokalise::Resources::Task.find @token, project_id, task_id
    end

    def create_task(project_id, params)
      Lokalise::Resources::Task.create @token, project_id, params
    end

    def update_task(project_id, task_id, params = {})
      Lokalise::Resources::Task.update @token, project_id, task_id, params
    end

    def delete_task(project_id, task_id)
      Lokalise::Resources::Task.destroy @token, project_id, task_id
    end
  end
end

module Lokalise
  class Client
    def projects(params = {})
      Lokalise::Collections::Project.all self, params
    end

    def project(project_id)
      Lokalise::Resources::Project.find self, nil, project_id
    end

    def create_project(params)
      Lokalise::Resources::Project.create self, nil, params
    end

    def update_project(project_id, params)
      Lokalise::Resources::Project.update self, nil, project_id, params
    end

    def empty_project(project_id)
      Lokalise::Resources::Project.clear self, project_id
    end

    def delete_project(project_id)
      Lokalise::Resources::Project.destroy self, nil, project_id
    end
  end
end

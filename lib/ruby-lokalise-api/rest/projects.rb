module Lokalise
  class Client
    def projects(params = {})
      Lokalise::Collections::Project.all @token, params
    end

    def project(project_id)
      Lokalise::Resources::Project.find @token, nil, project_id
    end

    def create_project(params)
      Lokalise::Resources::Project.create @token,
                                          nil,
                                          params
    end

    def update_project(project_id, params)
      Lokalise::Resources::Project.update @token, project_id, nil, params
    end

    def empty_project(project_id)
      Lokalise::Resources::Project.clear @token, project_id
    end

    def delete_project(project_id)
      Lokalise::Resources::Project.destroy @token, project_id, nil
    end
  end
end

module Lokalise
  class Client
    attr_reader :token

    def initialize(token)
      @token = token
    end

    # Projects endpoint

    def projects(params = {})
      Lokalise::Collections::Project.all @token, params
    end

    def project(project_id)
      Lokalise::Resources::Project.find @token, project_id
    end

    def create_project(params)
      Lokalise::Resources::Project.create @token, params
    end

    def update_project(project_id, params)
      Lokalise::Resources::Project.update @token, project_id, params
    end

    def empty_project(project_id)
      Lokalise::Resources::Project.clear @token, project_id
    end

    def delete_project(project_id)
      Lokalise::Resources::Project.destroy @token, project_id
    end
  end
end
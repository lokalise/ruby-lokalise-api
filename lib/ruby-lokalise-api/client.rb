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

    # Languages endpoint

    def system_languages(params = {})
      Lokalise::Collections::SystemLanguage.all @token, params
    end

    def project_languages(project_id, params = {})
      Lokalise::Collections::ProjectLanguage.all @token, params.merge(id: project_id)
    end

    def language(project_id, language_id)
      Lokalise::Resources::ProjectLanguage.find @token, project_id, language_id
    end

    def create_language(project_id, params)
      Lokalise::Resources::ProjectLanguage.create @token, project_id, params
    end

    def update_language(project_id, language_id, params)
      Lokalise::Resources::ProjectLanguage.update @token, project_id, language_id, params
    end

    def delete_language(project_id, language_id)
      Lokalise::Resources::ProjectLanguage.destroy @token, project_id, language_id
    end

    # Teams endpoint

    def teams(params = {})
      Lokalise::Collections::Team.all @token, params
    end
  end
end

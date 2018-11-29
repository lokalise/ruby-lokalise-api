module Lokalise
  class Client
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
  end
end

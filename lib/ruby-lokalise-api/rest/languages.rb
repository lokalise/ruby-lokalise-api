module Lokalise
  class Client
    def system_languages(params = {})
      Lokalise::Collections::SystemLanguage.all self, params
    end

    def project_languages(project_id, params = {})
      Lokalise::Collections::ProjectLanguage.all self, params, project_id
    end

    def language(project_id, language_id)
      Lokalise::Resources::ProjectLanguage.find self, project_id, language_id
    end

    def create_languages(project_id, params)
      Lokalise::Resources::ProjectLanguage.create self, project_id, params, :languages
    end

    def update_language(project_id, language_id, params)
      Lokalise::Resources::ProjectLanguage.update self, project_id, language_id, params
    end

    def delete_language(project_id, language_id)
      Lokalise::Resources::ProjectLanguage.destroy self, project_id, language_id
    end
  end
end

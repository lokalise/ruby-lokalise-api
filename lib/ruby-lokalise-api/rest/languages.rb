module Lokalise
  class Client
    # Returns all languages supported by Lokalise
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-system-languages-get
    # @return [Lokalise::Collection::SystemLanguage<Lokalise::Resources::SystemLanguage>]
    # @param params [Hash]
    def system_languages(params = {})
      Lokalise::Collections::SystemLanguage.all self, params
    end

    # Returns all languages for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-project-languages-get
    # @return [Lokalise::Collection::ProjectLanguage<Lokalise::Resources::ProjectLanguage>]
    # @param project_id [String, Integer]
    # @param params [Hash]
    def project_languages(project_id, params = {})
      Lokalise::Collections::ProjectLanguage.all self, params, project_id
    end

    # Returns a single language for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-language-get
    # @return [Lokalise::Resources::ProjectLanguage]
    # @param project_id [String]
    # @param language_id [String, Integer]
    def language(project_id, language_id)
      Lokalise::Resources::ProjectLanguage.find self, project_id, language_id
    end

    # Creates one or more language for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-language-get
    # @return [Lokalise::Collection::ProjectLanguage<Lokalise::Resources::ProjectLanguage>]
    # @param project_id [String]
    # @param params [Hash]
    def create_languages(project_id, params)
      Lokalise::Resources::ProjectLanguage.create self, project_id, params, :languages
    end

    # Updates language for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-language-put
    # @return [Lokalise::Resources::ProjectLanguage]
    # @param project_id [String]
    # @param language_id [String, Integer]
    # @param params [Hash]
    def update_language(project_id, language_id, params)
      Lokalise::Resources::ProjectLanguage.update self, project_id, language_id, params
    end

    # Deletes language for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-language-delete
    # @return [Hash]
    # @param project_id [String]
    # @param language_id [String, Integer]
    def delete_language(project_id, language_id)
      Lokalise::Resources::ProjectLanguage.destroy self, project_id, language_id
    end
  end
end

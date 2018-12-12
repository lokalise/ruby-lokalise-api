module Lokalise
  class Client
    # Returns all languages supported by Lokalise
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-system-languages-get
    # @return [Lokalise::Collection::SystemLanguage<Lokalise::Resources::SystemLanguage>]
    # @param params [Hash]
    def system_languages(params = {})
      c_r Lokalise::Collections::SystemLanguage, :all, nil, params
    end

    # Returns all languages for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-project-languages-get
    # @return [Lokalise::Collection::ProjectLanguage<Lokalise::Resources::ProjectLanguage>]
    # @param project_id [String, Integer]
    # @param params [Hash]
    def project_languages(project_id, params = {})
      c_r Lokalise::Collections::ProjectLanguage, :all, project_id, params
    end

    # Returns a single language for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-language-get
    # @return [Lokalise::Resources::ProjectLanguage]
    # @param project_id [String]
    # @param language_id [String, Integer]
    def language(project_id, language_id)
      c_r Lokalise::Resources::ProjectLanguage, :find, [project_id, language_id]
    end

    # Creates one or more language for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-language-get
    # @return [Lokalise::Collection::ProjectLanguage<Lokalise::Resources::ProjectLanguage>]
    # @param project_id [String]
    # @param params [Hash]
    def create_languages(project_id, params)
      c_r Lokalise::Resources::ProjectLanguage, :create, project_id, params, :languages
    end

    # Updates language for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-language-put
    # @return [Lokalise::Resources::ProjectLanguage]
    # @param project_id [String]
    # @param language_id [String, Integer]
    # @param params [Hash]
    def update_language(project_id, language_id, params)
      c_r Lokalise::Resources::ProjectLanguage, :update, [project_id, language_id], params
    end

    # Deletes language for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-language-delete
    # @return [Hash]
    # @param project_id [String]
    # @param language_id [String, Integer]
    def delete_language(project_id, language_id)
      c_r Lokalise::Resources::ProjectLanguage, :destroy, [project_id, language_id]
    end
  end
end

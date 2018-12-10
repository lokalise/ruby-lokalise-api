module Lokalise
  class Client
    # Returns all translations for the given project (ungrouped)
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-translations-get
    # @return [Lokalise::Collection::Translation<Lokalise::Resources::Translation>]
    # @param project_id [String]
    # @param params [Hash]
    def translations(project_id, params = {})
      Lokalise::Collections::Translation.all self, params, project_id
    end

    # Returns translation of the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-translation-get
    # @return [Lokalise::Resources::Translation]
    # @param project_id [String]
    # @param translation_id [String, Integer]
    # @param params [Hash]
    def translation(project_id, translation_id, params = {})
      Lokalise::Resources::Translation.find self, project_id, translation_id, params
    end

    # Updates translation of the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-translation-put
    # @return [Lokalise::Resources::Translation]
    # @param project_id [String]
    # @param translation_id [String, Integer]
    # @param params [Hash]
    def update_translation(project_id, translation_id, params)
      Lokalise::Resources::Translation.update self, project_id, translation_id, params
    end
  end
end

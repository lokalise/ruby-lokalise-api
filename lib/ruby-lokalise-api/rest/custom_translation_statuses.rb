module Lokalise
  class Client
    # Returns all translation statuses for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-custom-translation-statuses-get
    # @return [Lokalise::Collection::CustomTranslationStatus<Lokalise::Resources::CustomTranslationStatus>]
    # @param project_id [String]
    # @param params [Hash]
    def translation_statuses(project_id, params = {})
      c_r Lokalise::Collections::CustomTranslationStatus, :all, project_id, params
    end

    # Returns a single translation status for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-custom-translation-status-get
    # @return [Lokalise::Resources::CustomTranslationStatus]
    # @param project_id [String]
    # @param status_id [String, Integer]
    def translation_status(project_id, status_id)
      c_r Lokalise::Resources::CustomTranslationStatus, :find, [project_id, status_id]
    end

    # Creates translation status inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-a-custom-translation-status-post
    # @return Lokalise::Resources::CustomTranslationStatus
    # @param project_id [String]
    # @param params Hash
    def create_translation_status(project_id, params)
      c_r Lokalise::Resources::CustomTranslationStatus, :create, project_id, params
    end

    # Updates the given translation status inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-custom-translation-status-put
    # @return [Lokalise::Resources::CustomTranslationStatus]
    # @param project_id [String]
    # @param status_id [String, Integer]
    # @param params [Hash]
    def update_translation_status(project_id, status_id, params)
      c_r Lokalise::Resources::CustomTranslationStatus, :update, [project_id, status_id], params
    end

    # Deletes translation status inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-custom-translation-status-delete
    # @return [Hash]
    # @param project_id [String]
    # @param status_id [String, Integer]
    def destroy_translation_status(project_id, status_id)
      c_r Lokalise::Resources::CustomTranslationStatus, :destroy, [project_id, status_id]
    end

    # Returns an array of available colors that can be assigned to custom translation statuses
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-available-colors-for-custom-translation-statuses-get
    # @return [Array]
    # @param project_id [String]
    def translation_status_colors(project_id)
      c_r Lokalise::Resources::CustomTranslationStatus, :colors, [project_id, 'colors']
    end
  end
end

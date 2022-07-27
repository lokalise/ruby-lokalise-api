# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module CustomTranslationStatuses
      # Returns all translation statuses for the given project
      #
      # @see https://developers.lokalise.com/reference/list-all-custom-translation-statuses
      # @return [RubyLokaliseApi::Collection::CustomTranslationStatus<RubyLokaliseApi::Resources::CustomTranslationStatus>]
      # @param project_id [String]
      # @param params [Hash]
      def translation_statuses(project_id, params = {})
        c_r RubyLokaliseApi::Collections::CustomTranslationStatus, :all, project_id, params
      end

      # Returns a single translation status for the given project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-custom-translation-status
      # @return [RubyLokaliseApi::Resources::CustomTranslationStatus]
      # @param project_id [String]
      # @param status_id [String, Integer]
      def translation_status(project_id, status_id)
        c_r RubyLokaliseApi::Resources::CustomTranslationStatus, :find, [project_id, status_id]
      end

      # Creates translation status inside the given project
      #
      # @see https://developers.lokalise.com/reference/create-a-custom-translation-status
      # @return RubyLokaliseApi::Resources::CustomTranslationStatus
      # @param project_id [String]
      # @param params Hash
      def create_translation_status(project_id, params)
        c_r RubyLokaliseApi::Resources::CustomTranslationStatus, :create, project_id, params
      end

      # Updates the given translation status inside the given project
      #
      # @see https://developers.lokalise.com/reference/update-a-custom-translation-status
      # @return [RubyLokaliseApi::Resources::CustomTranslationStatus]
      # @param project_id [String]
      # @param status_id [String, Integer]
      # @param params [Hash]
      def update_translation_status(project_id, status_id, params)
        c_r RubyLokaliseApi::Resources::CustomTranslationStatus, :update, [project_id, status_id], params
      end

      # Deletes translation status inside the given project
      #
      # @see https://developers.lokalise.com/reference/delete-a-custom-translation-status
      # @return [Hash]
      # @param project_id [String]
      # @param status_id [String, Integer]
      def destroy_translation_status(project_id, status_id)
        c_r RubyLokaliseApi::Resources::CustomTranslationStatus, :destroy, [project_id, status_id]
      end

      # Returns an array of available colors that can be assigned to custom translation statuses
      #
      # @see https://developers.lokalise.com/reference/retrieve-available-colors-for-custom-translation-statuses
      # @return [Array]
      # @param project_id [String]
      def translation_status_colors(project_id)
        c_r RubyLokaliseApi::Resources::CustomTranslationStatus, :colors, [project_id, 'colors']
      end
    end
  end
end

# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module CustomTranslationStatuses
      # Returns a custom translation status
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-status
      # @return [RubyLokaliseApi::Resources::CustomTranslationStatus]
      # @param project_id [String]
      # @param status_id [String, Integer]
      def custom_translation_status(project_id, status_id)
        params = { query: [project_id, status_id] }

        data = endpoint(name: 'CustomTranslationStatuses', params: params).do_get

        resource 'CustomTranslationStatus', data
      end

      # Returns custom translation statuses for the project
      #
      # @see https://developers.lokalise.com/reference/list-all-statuses
      # @return [RubyLokaliseApi::Collections::CustomTranslationStatuses]
      # @param project_id [String]
      # @param req_params [Hash]
      def custom_translation_statuses(project_id, req_params = {})
        name = 'CustomTranslationStatuses'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Creates a custom translation status
      #
      # @see https://developers.lokalise.com/reference/create-a-status
      # @return [RubyLokaliseApi::Resources::CustomTranslationStatus]
      # @param project_id [String]
      # @param req_params [Hash]
      def create_custom_translation_status(project_id, req_params)
        params = { query: project_id, req: req_params }

        data = endpoint(name: 'CustomTranslationStatuses', params: params).do_post

        resource 'CustomTranslationStatus', data
      end

      # Updates a custom translation status
      #
      # @see https://developers.lokalise.com/reference/update-a-status
      # @return [RubyLokaliseApi::Resources::CustomTranslationStatus]
      # @param project_id [String]
      # @param status_id [Integer, String]
      # @param req_params [Hash]
      def update_custom_translation_status(project_id, status_id, req_params = {})
        params = { query: [project_id, status_id], req: req_params }

        data = endpoint(name: 'CustomTranslationStatuses', params: params).do_put

        resource 'CustomTranslationStatus', data
      end

      # Deletes a custom translation status
      #
      # @see https://developers.lokalise.com/reference/delete-a-status
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param status_id [Integer, String]
      def destroy_custom_translation_status(project_id, status_id)
        params = { query: [project_id, status_id] }

        data = endpoint(name: 'CustomTranslationStatuses', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end

      # Retrieves an array of available colors that can be assigned to custom translation statuses
      #
      # @see https://developers.lokalise.com/reference/retrieve-available-colors
      # @return [RubyLokaliseApi::Generics::CustomStatusAvailableColors]
      # @param project_id [String]
      def custom_translation_status_colors(project_id)
        params = { query: [project_id, :colors] }

        data = endpoint(name: 'CustomTranslationStatuses', params: params).do_get

        RubyLokaliseApi::Generics::CustomStatusAvailableColors.new data.content
      end
    end
  end
end

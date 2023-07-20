# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Translations
      # Returns translations
      #
      # @see https://developers.lokalise.com/reference/list-all-translations
      # @return [RubyLokaliseApi::Collections::Translations]
      # @param project_id [String]
      # @param req_params [Hash]
      def translations(project_id, req_params = {})
        name = 'Translations'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single translation
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-translation
      # @return [RubyLokaliseApi::Resources::Translation]
      # @param project_id [String]
      # @param translation_id [String]
      # @param req_params[Hash]
      def translation(project_id, translation_id, req_params = {})
        params = { query: [project_id, translation_id], req: req_params }

        data = endpoint(name: 'Translations', params: params).do_get

        resource 'Translation', data
      end

      # Updates a translation
      #
      # @see https://developers.lokalise.com/reference/update-a-translation
      # @return [RubyLokaliseApi::Resources::Translation]
      # @param project_id [String]
      # @param translation_id [String]
      # @param req_params [Hash]
      def update_translation(project_id, translation_id, req_params)
        params = { query: [project_id, translation_id], req: req_params }

        data = endpoint(name: 'Translations', params: params).do_put

        resource 'Translation', data
      end
    end
  end
end

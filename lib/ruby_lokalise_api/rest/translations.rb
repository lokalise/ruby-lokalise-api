# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Translations
      # Returns all translations for the given project (ungrouped)
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-translations-get
      # @return [RubyLokaliseApi::Collection::Translation<RubyLokaliseApi::Resources::Translation>]
      # @param project_id [String]
      # @param params [Hash]
      def translations(project_id, params = {})
        c_r RubyLokaliseApi::Collections::Translation, :all, project_id, params
      end

      # Returns translation of the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-translation-get
      # @return [RubyLokaliseApi::Resources::Translation]
      # @param project_id [String]
      # @param translation_id [String, Integer]
      # @param params [Hash]
      def translation(project_id, translation_id, params = {})
        c_r RubyLokaliseApi::Resources::Translation, :find, [project_id, translation_id], params
      end

      # Updates translation of the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-update-a-translation-put
      # @return [RubyLokaliseApi::Resources::Translation]
      # @param project_id [String]
      # @param translation_id [String, Integer]
      # @param params [Hash]
      def update_translation(project_id, translation_id, params)
        c_r RubyLokaliseApi::Resources::Translation, :update, [project_id, translation_id], params
      end
    end
  end
end

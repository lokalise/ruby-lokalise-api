# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Languages
      # Returns all languages supported by Lokalise
      #
      # @see https://developers.lokalise.com/reference/list-system-languages
      # @return [RubyLokaliseApi::Collection::SystemLanguage<RubyLokaliseApi::Resources::SystemLanguage>]
      # @param params [Hash]
      def system_languages(params = {})
        c_r RubyLokaliseApi::Collections::SystemLanguage, :all, nil, params
      end

      # Returns all languages for the given project
      #
      # @see https://developers.lokalise.com/reference/list-project-languages
      # @return [RubyLokaliseApi::Collection::ProjectLanguage<RubyLokaliseApi::Resources::ProjectLanguage>]
      # @param project_id [String, Integer]
      # @param params [Hash]
      def project_languages(project_id, params = {})
        c_r RubyLokaliseApi::Collections::ProjectLanguage, :all, project_id, params
      end

      # Returns a single language for the given project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-language
      # @return [RubyLokaliseApi::Resources::ProjectLanguage]
      # @param project_id [String]
      # @param language_id [String, Integer]
      def language(project_id, language_id)
        c_r RubyLokaliseApi::Resources::ProjectLanguage, :find, [project_id, language_id]
      end

      # Creates one or more language for the given project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-language
      # @return [RubyLokaliseApi::Collection::ProjectLanguage<RubyLokaliseApi::Resources::ProjectLanguage>]
      # @param project_id [String]
      # @param params [Hash]
      def create_languages(project_id, params)
        c_r RubyLokaliseApi::Resources::ProjectLanguage, :create, project_id, params, :languages
      end

      # Updates language for the given project
      #
      # @see https://developers.lokalise.com/reference/update-a-language
      # @return [RubyLokaliseApi::Resources::ProjectLanguage]
      # @param project_id [String]
      # @param language_id [String, Integer]
      # @param params [Hash]
      def update_language(project_id, language_id, params)
        c_r RubyLokaliseApi::Resources::ProjectLanguage, :update, [project_id, language_id], params
      end

      # Deletes language for the given project
      #
      # @see https://developers.lokalise.com/reference/delete-a-language
      # @return [Hash]
      # @param project_id [String]
      # @param language_id [String, Integer]
      def destroy_language(project_id, language_id)
        c_r RubyLokaliseApi::Resources::ProjectLanguage, :destroy, [project_id, language_id]
      end
    end
  end
end
